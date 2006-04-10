#!/usr/bin/env python
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#                             Charles A. Williams
#                       Rensselaer Polytechnic Institute
#             Copyright (C) 2006 Rensselaer Polytechnic Institute
#
# 
# 	Permission is hereby granted, free of charge, to any person
# 	obtaining a copy of this software and associated documentation
# 	files (the "Software"), to deal in the Software without
# 	restriction, including without limitation the rights to use,
# 	copy, modify, merge, publish, distribute, sublicense, and/or
# 	sell copies of the Software, and to permit persons to whom the
# 	Software is furnished to do so, subject to the following
# 	conditions:
# 
# 	The above copyright notice and this permission notice shall be
# 	included in all copies or substantial portions of the Software.
# 
# 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# 	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# 	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# 	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# 	OTHER DEALINGS IN THE SOFTWARE.
#         
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Initial attempt at a module that gets a Mesh object from Tecton-style input files.

class MeshImporterTecton(MeshImporter):
  """Class for importing a mesh using Tecton-style (original LithoMop) input files."""

  class Inventory(MeshImporter.Inventory):

    import pyre.inventory

    coordFile = pyre.inventory.str("coordFile",default="")
    elemFile = pyre.inventory.str("elemFile",default="")
    f77FileInput = pyre.inventory.int("f77FileInput", default=10)
    maxNumElemFamilies = pyre.inventory.int("maxNumElemFamilies", default=1024)


  def generate(self, fileRoot):
    """Get a finite element mesh."""

    from lithomop3d.Mesh import Mesh
    mesh = Mesh()

    # Get nodes
    mesh.nodes = self._getNodes(fileRoot)

    # Get elements and define element families and materials
    mesh.elements, mesh.elemFamilies = self._getElems(fileRoot)

    return mesh

  def _getNodes(self, fileRoot):
    """Gets dimensions and nodal coordinates from Tecton-style input file."""

    import pyre.units
    import lithomop3d as lm3d

    # Get input filename
    if self.inventory.coordFile == "":
      coordInputFile = fileRoot + ".coord"
    else:
      coordInputFile = self.inventory.coordFile

    f77FileInput = self.inventory.f77FileInput
    
    numNodes, numDims, coordUnits = lm3d.scan_coords(
      f77FileInput,
      coordInputFile)

    coordScaleString = \
                     uparser.parse(string.strip(coordUnits))
    coordScaleFactor = coordScaleString.value

    ptrCoords = lm3d.allocateDouble(numDims*numNodes)

    nodes = { 'numNodes': numNodes,
              'dim': numDims,
              'ptrCoords': ptrCoords }

    lm3d.read_coords(nodes['ptrCoords'],
                     coordScaleFactor,
                     nodes['numNodes'],
                     nodes['dim'],
                     f77FileInput,
                     coordInputFile)

    return nodes
      

  def _getElems(self, fileRoot):
    """Gets dimensions and element nodes from Tecton-style input file, and
    defines element families based on element group number."""

    import lithomop3d as lm3d

    # Get input filename
    if self.inventory.elemFile == "":
      elemInputFile = fileRoot + ".connect"
    else:
      elemInputFile = self.inventory.elemFile

    f77FileInput = self.inventory.f77FileInput
    maxNumElemFamilies = self.inventory.maxNumElemFamilies
    
    ptrNumNodesPerElemType = lm3d.intListToArray(mesh.numNodesPerElemType)
    numElemTypes = len(mesh.numNodesPerElemType)
    # I am changing the way this is done for now, under the assumption that we
    # will be using f2py to generate bindings.  This will allow me to 'see'
    # specified arrays as lists in python.
    # ptrTmpElemFamilySizes = lithomop3d.allocateInt(maxNumElemFamilies)
    tmpElemFamilySizes = [0]*maxNumElemFamilies
    tmpElemFamilyTypes = [0]*maxNumElemFamilies
    tmpElemFamilyIds = [0]*maxNumElemFamilies

    # I need to check that I've included everything here, and I will also need
    # to change the routine arguments and bindings.
    numElems,
    numElemFamilies,
    tmpElemFamilySizes,
    tmpElemFamilyTypes,
    tmpElemFamilyIds = lm3d.scan_connect(
      ptrNumNodesPerElemType,
      numElemTypes,
      maxNumElemFamilies,
      f77FileInput,
      elemInputFile)

    # Compact temporary element family arrays to get actual arrays, and
    # determine size of element node array.
    elemFamilySizes = []
    elemFamilyTypes = []
    elemFamilyIds = []
    elemNodeArraySize = 0

    for i in range(maxNumElemFamilies):
      if tmpElemFamilySizes[i] != 0 and tmpElemFamilyTypes[i] != 0 and tmpElemFamilyIds[i] != 0:
        elemFamilySizes.append(tmpElemFamilySizes[i])
        elemFamilyTypes.append(tmpElemFamilyTypes[i])
        elemFamilyIds.append(tmpElemFamilyIds[i])
        elemNodeArraySize += tmpElemFamilySizes[i]*mesh.numNodesPerElemType[tmpElemFamilyTypes[i]]

    tmpElemFamilySizes = None
    tmpElemFamilyTypes = None
    tmpElemFamilyIds = None

    elemFamilyError = "ElemFamily Error"
    if len(elemFamilySizes) != numElemFamilies:
      raise elemFamilyError, "Number of element families does not match input!"

    # Create elements dictionary
    ptrElemNodeArray = lm3d.allocateInt(elemNodeArraySize)
    ptrElemInitOrder = lm3d.allocateInt(numElems)

    elements = {'numElems': numElems,
                'ptrElemNodeArray': ptrElemNodeArray,
                'ptrElemInitOrder': ptrElemInitOrder}

    # Create element families dictionary
    elemFamilies = {'numElemFamilies': numElemFamilies,
                    'elemFamilySizes': elemFamilySizes,
                    'elemFamilyTypes': elemFamilyTypes,
                    'elemFamilyIds': elemFamilyIds}
      
    # Need to do a lot more fixing.
    # New idea for how to deal with families:  Rather than sorting the elements
    # (using the reorder routine).  Have a routine that just puts the elements in
    # their family and keep a 1D array with the associated element number.
    # All other 
    lithomop3d.read_connect(
      elements,
      elemFamily,
      ptrTmpElemFamilySizes,
      maxNumElemFamilies,
      f77FileInput,
      elemInputFile)

    return elements, elemFamilies
      
    
  def __init__(self, name="meshimporter"):
    """Constructor."""

    Mesher.__init__(self, name)

    return
        

# version
__id__ = "$Id$"

# End of file 
