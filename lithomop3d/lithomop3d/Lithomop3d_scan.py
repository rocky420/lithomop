#!/usr/bin/env python
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#  Lithomop3d by Charles A. Williams
#  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject to
#  the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
#  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
#  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
#  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
#  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
#  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#


from pyre.components.Component import Component
import os


class Lithomop3d_scan(Component):


    def __init__(self):
        Component.__init__(self, "lm3dscan", "scanner")

        from pyre.units.pressure import Pa
        from pyre.units.length import m
        from pyre.units.time import s

	print ""
        print "Hello from lm3dscan.__init__ (begin)!"
        print "Setting default keyword values:"

        # default values for extra input (category 2)
        # these can be overriden using a script or keyword=value file

        self.winklerScaleX = 1.0
        self.winklerScaleY = 1.0
        self.winklerScaleZ = 1.0

        self.stressTolerance = 1.0e-12*Pa
        self.minimumStrainPerturbation = 1.0e-7
        self.initialStrainPerturbation = 1.0e-1

        self.usePreviousDisplacementFlag = 0

        self.quadratureOrder = "Full"

        self.gravityX = 0.0*m/(s*s)
        self.gravityY = 0.0*m/(s*s)
        self.gravityZ = 0.0*m/(s*s)

        self.prestressAutoCompute = False
        self.prestressAutoChangeElasticProps = False
        self.prestressAutoComputePoisson = 0.49
        self.prestressAutoComputeYoungs = 1.0e30*Pa

        self.prestressScaleXx = 1.0
        self.prestressScaleYy = 1.0
        self.prestressScaleZz = 1.0
        self.prestressScaleXy = 1.0
        self.prestressScaleXz = 1.0
        self.prestressScaleYz = 1.0

        self.winklerSlipScaleX = 1.0
        self.winklerSlipScaleY = 1.0
        self.winklerSlipScaleZ = 1.0

        self.f77StandardInput = 5
        self.f77StandardOutput = 6
        self.f77FileInput = 10
        self.f77AsciiOutput = 11
        self.f77PlotOutput = 12
        self.f77UcdOutput = 13

	print ""
        print "Hello from lm3dscan.__init__ (end)!"
        
        return

# derived or automatically-specified quantities (category 3)

    def preinitialize(self):

        from Materials import Materials
        from KeywordValueParse import KeywordValueParse
        import pyre.units
        import lithomop3d
        import string

        uparser = pyre.units.parser()
        matinfo = Materials()
        keyparse = KeywordValueParse()

	print ""
        print "Hello from lm3dscan._init (begin)!"
        print "Scanning ascii files to determine dimensions:"

        # Initialization of all parameters
	# Memory size variable to keep approximate track of all
	# allocated memory.  This does not include python variables and
	# lists.
	self._memorySize = 0L
	self._intSize = 4L
	self._doubleSize = 8L
        # Parameters that are invariant for this geometry type
        self._geometryType = ""
        self._geometryTypeInt = 0
        self._numberSpaceDimensions = 0
        self._numberDegreesFreedom = 0
        # Note:  eventually the variable below should disappear, and the
        # total size of the state variable array for each material model
        # should be used instead.  This means that all state variable
        # bookkeeping should be done within the material model routines.
        self._stateVariableDimension = 0
        self._materialMatrixDimension = 0
        self._numberSkewDimensions = 0
        self._numberSlipDimensions = 0
        self._numberSlipNeighbors = 0
        self._numberTractionDirections = 0
        self._listIddmat = [0]

        # Invariant parameters related to element type
        self._numberElementTypes = 0
        self._numberElementTypesBase = 0
        self._numberElementNodesBase = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        self._pointerToListArrayNumberElementNodesBase = None

        # Invariant parameters related to material model
        self._maxMaterialModels = 0
        self._maxStateVariables = 0
        self._maxState0Variables = 0
        self._pointerToMaterialModelInfo = None

        # Parameters derived from values in the inventory or the
        # category 2 parameters above.
        self._analysisTypeInt = 0
        self._prestressAutoComputeInt = 0
        self._prestressAutoChangeElasticPropsInt = 0
        self._pointerToSh = None
        self._pointerToShj = None
        self._pointerToGauss = None

        # Parameters derived from the number of entries in a file

        self._numberNodes = 0
        self._coordinateUnits = "coordinateUnitsInitial12345678"
        self._coordinateScaleFactor = 0.0

        self._numberBcEntries = 0
        self._displacementUnits = "displacementUnitsInitial123456"
        self._displacementScaleFactor = 0.0
        self._velocityUnits = "velocityUnitsInitial1234567890"
        self._velocityScaleFactor = 0.0
        self._forceUnits = "forceUnitsInitial1234567890123"
        self._forceScaleFactor = 0.0

	self._winklerInfo = [0, 0]
        self._numberWinklerEntries = 0
        self._numberWinklerForces = 0

        self._numberRotationEntries = 0
        self._rotationUnits = "rotationUnitsInitial1234567890"
        self._rotationScaleFactor = 0.0

        self._timeStepInfo = [0, 0]
        self._numberTimeStepGroups = 0
        self._totalNumberTimeSteps = 0
        self._timeUnits = "timeUnitsInitial12345678901234"
        self._timeScaleFactor = 0.0

        self._numberFullOutputs = 0

        self._numberLoadHistories = 0

        self._numberMaterials = 0
        self._propertyListSize = 0
        self._propertyList = [0]
        self._pointerToListArrayPropertyList = None
        self._propertyListIndex = [0]
        self._pointerToListArrayPropertyListIndex = None
        self._materialModel = [0]
        self._pointerToListArrayMaterialModel = None

        self._volumeElementDimens = [0, 0, 0]
        self._numberVolumeElements = 0
        self._volumeElementType = 0
        self._numberVolumeElementFamilies = 0
        self._maxNumberVolumeElementFamilies = 0
        self._numberAllowedVolumeElementTypes = 0
        self._pointerToVolumeElementFamilyList = None

        self._numberPrestressEntries = 0

        self._numberTractionBc = 0
        self._tractionBcUnits = "tractionBcUnitsInitial12345678"
        self._tractionBcScaleFactor = 0.0
        self._tractionFlag = 0

        self._numberSplitNodeEntries = 0

        self._numberSlipperyNodeEntries = 0
        self._numberDifferentialForceEntries = 0
	self._slipperyWinklerInfo = [0, 0]
        self._numberSlipperyWinklerEntries = 0
        self._numberSlipperyWinklerForces = 0

        self._summaryIOError = self.CanNotOpenInputOutputFilesError()

        inputFile = self.inputFile
        inputFileStream = self.inputFileStream
        outputFile = self.outputFile
        macroString = self.macroString

        #                              open?   fatal?  label
        optional = self.IOFileCategory(True,   0,      "optional")
        unused   = self.IOFileCategory(False,  0,      "unused")
        required = self.IOFileCategory(True,   1,       None)
        
        Inventory = Lithomop3d_scan.Inventory

        # First see if there is a keyword = value file, which may be used
        # to override parameters from __init__.

        self._keywordEqualsValueFile = inputFileStream(Inventory.keywordEqualsValueFile, optional)

        # print self._keywordEqualsValueFile.name
        if self._keywordEqualsValueFile:
            stream = self._keywordEqualsValueFile
            while 1:
                line = stream.readline()
                if not line: break
                keyvals = keyparse.parseline(line)
                if keyvals[3]:
		    if type(keyvals[2]) == str:
		        exec 'self.' + keyvals[0] + '=' + "keyvals[2]"
                    elif type(keyvals[2]) == pyre.units.unit.unit:
                        exec 'self.' + keyvals[0] + '=' + 'uparser.parse(str(keyvals[2]))'
		    else:
		        exec 'self.' + keyvals[0] + '=' + str(keyvals[2])
            stream.close()

        # Define information needed from other functions:
        f77FileInput = self.f77FileInput
        prestressAutoCompute = self.prestressAutoCompute
        prestressAutoChangeElasticProps = self.prestressAutoChangeElasticProps
        quadratureOrder = self.quadratureOrder
        
        analysisType = self.inventory.analysisType

        self._asciiOutputFile             = outputFile(Inventory.asciiOutputFile,            required)
        self._plotOutputFile              = outputFile(Inventory.plotOutputFile,              required)
        self._coordinateInputFile         = inputFile(Inventory.coordinateInputFile,         required)
        self._bcInputFile                 = inputFile(Inventory.bcInputFile,                 required)
        self._winklerInputFile            = inputFile(Inventory.winklerInputFile,            optional)
        self._rotationInputFile           = inputFile(Inventory.rotationInputFile,           optional)
        self._timeStepInputFile           = inputFile(Inventory.timeStepInputFile,           required)
        self._fullOutputInputFile         = inputFile(Inventory.fullOutputInputFile, analysisType == "fullSolution" and required or unused)
        self._stateVariableInputFile      = inputFile(Inventory.stateVariableInputFile,      required)
        self._loadHistoryInputFile        = inputFile(Inventory.loadHistoryInputFile,        optional)
        self._materialPropertiesInputFile = inputFile(Inventory.materialPropertiesInputFile, required)
        self._materialHistoryInputFile    = inputFile(Inventory.materialHistoryInputFile,    unused)
        self._connectivityInputFile       = inputFile(Inventory.connectivityInputFile,       required)
        self._prestressInputFile          = inputFile(Inventory.prestressInputFile,          unused)
        self._tractionInputFile           = inputFile(Inventory.tractionInputFile,           unused)
        self._splitNodeInputFile          = inputFile(Inventory.splitNodeInputFile,          optional)
        self._slipperyNodeInputFile       = inputFile(Inventory.slipperyNodeInputFile,       optional)
        self._differentialForceInputFile  = inputFile(Inventory.differentialForceInputFile,  optional)
        self._slipperyWinklerInputFile    = inputFile(Inventory.slipperyWinklerInputFile,    optional)

        # The call to glob() is somewhat crude -- basically, determine
        # if any files might be in the way.
        self._ucdOutputRoot               = macroString(Inventory.ucdOutputRoot)
        from glob import glob
        ucdFiles = ([self._ucdOutputRoot + ".mesh.inp",
                     self._ucdOutputRoot + ".gmesh.inp",
                     self._ucdOutputRoot + ".mesh.time.prest.inp",
                     self._ucdOutputRoot + ".gmesh.time.prest.inp"]
                    + glob(self._ucdOutputRoot + ".mesh.time.[0-9][0-9][0-9][0-9][0-9].inp")
                    + glob(self._ucdOutputRoot + ".gmesh.time.[0-9][0-9][0-9][0-9][0-9].inp"))
        trait = Inventory.ucdOutputRoot
        for ucdFile in ucdFiles:
            try:
                stream = os.fdopen(os.open(ucdFile, os.O_WRONLY|os.O_CREAT|os.O_EXCL), "w")
            except (OSError, IOError), error:
                descriptor = self.inventory.getTraitDescriptor(trait.name)
                self._summaryIOError.openFailed(trait, descriptor,self._ucdOutputRoot + ".*mesh*.inp", error, required)
                break
            else:
                stream.close()
                os.remove(ucdFile)

        if self._summaryIOError.fatalIOErrors():
            raise self._summaryIOError

        # This is a test version where the geometry type is automatically
        # specified by using Lithomop3d.  The geometry type is only used for
        # f77 routines and not in pyre. An integer value is also defined
        # for use in f77 routines.
        # Define some integer values that are derived from string variables.

        # Parameters that are invariant for this geometry type
        self._geometryType = "3D"
        self._geometryTypeInt = 4
        self._numberSpaceDimensions = 3
        self._numberDegreesFreedom = 3
        self._stateVariableDimension = 6
        self._materialMatrixDimension = 21
        self._numberSkewDimensions = 2
        self._numberSlipDimensions = 5
        self._numberSlipNeighbors = 4
        self._numberTractionDirections = 2
        # self._listIddmat = [
        #     1, 2, 3, 4, 5, 6,
        #     2, 7, 8, 9,10,11,
        #     3, 8,12,13,14,15,
        #     4, 9,13,16,17,18,
        #     5,10,14,17,19,20,
        #     6,11,15,18,20,21]
        # Changed this to correspond to BLAS packed symmetric matrix format.
        self._listIddmat = [
             1, 2, 4, 7,11,16,
             2, 3, 5, 8,12,17,
             4, 5, 6, 9,13,18,
             7, 8, 9,10,14,19,
            11,12,13,14,15,20,
            16,17,18,19,20,21]

        # Invariant parameters related to element type
        self._maxElementNodes = 20
        self._maxGaussPoints = 27
        self._maxElementEquations = self._numberDegreesFreedom*self._maxElementNodes
        self._numberElementTypes = 62
        self._numberElementTypesBase = 10
        self._numberElementNodesBase = [8, 7, 6, 5, 4, 20, 18, 15, 13, 10]
        self._pointerToListArrayNumberElementNodesBase = lithomop3d.intListToArray(
            self._numberElementNodesBase)
	self._memorySize += self._numberElementTypesBase*self._intSize

        # Invariant parameters related to material model
        self._maxMaterialModels = 20
        self._maxStateVariables = 24
        self._maxState0Variables = 6
        self._pointerToMaterialModelInfo = lithomop3d.allocateInt(
            6*self._maxMaterialModels)
	self._memorySize += 6*self._maxMaterialModels*self._intSize

        lithomop3d.matmod_def(
            self._pointerToMaterialModelInfo)

        # Parameters derived from values in the inventory or the
        # category 2 parameters above.
        analysisTypeMap = {
            "dataCheck":       0,
            "stiffnessFactor": 1,
            "elasticSolution": 2,
            "fullSolution":    3,
            }
        self._analysisTypeInt = analysisTypeMap[analysisType]

        if prestressAutoCompute:
            self._prestressAutoComputeInt = 1
        else:
            self._prestressAutoComputeInt = 0

        if prestressAutoChangeElasticProps:
            self._prestressAutoChangeElasticPropsInt = 1
        else:
            self._prestressAutoChangeElasticPropsInt = 0

        # Parameters derived from the number of entries in a file.
        self._numberNodes = lithomop3d.scan_coords(
            f77FileInput,
            self._coordinateUnits,
            self._coordinateInputFile)

        self._coordinateScaleString = \
                                    uparser.parse(string.strip(self._coordinateUnits))
        self._coordinateScaleFactor = self._coordinateScaleString.value

        self._numberBcEntries = lithomop3d.scan_bc(
            f77FileInput,
            self._displacementUnits,
            self._velocityUnits,
            self._forceUnits,
            self._bcInputFile)

        self._displacementScaleString = \
                                      uparser.parse(string.strip(self._displacementUnits))
        self._displacementScaleFactor = self._displacementScaleString.value
        self._velocityScaleString = \
                                  uparser.parse(string.strip(self._velocityUnits))
        self._velocityScaleFactor = self._velocityScaleString.value
        self._forceScaleString = \
                               uparser.parse(string.strip(self._forceUnits))
        self._forceScaleFactor = self._forceScaleString.value

        self._winklerInfo = lithomop3d.scan_wink(
            f77FileInput,
            self._winklerInputFile)
        self._numberWinklerEntries = self._winklerInfo[0]
        self._numberWinklerForces = self._winklerInfo[1]

        self._numberRotationEntries = lithomop3d.scan_skew(
            f77FileInput,
            self._rotationUnits,
            self._rotationInputFile)

        if self._numberRotationEntries != 0:
            self._rotationScaleString = \
                                      uparser.parse(string.strip(self._rotationUnits))
            self._rotationScaleFactor = self._rotationScaleString.value

        self._timeStepInfo = lithomop3d.scan_timdat(
            f77FileInput,
            self._timeUnits,
            self._timeStepInputFile)
        self._numberTimeStepGroups = self._timeStepInfo[0]
        self._totalNumberTimeSteps = self._timeStepInfo[1]

        self._timeScaleString = \
                              uparser.parse(string.strip(self._timeUnits))
        self._timeScaleFactor = self._timeScaleString.value

        self._numberFullOutputs = lithomop3d.scan_fuldat(
            self._analysisTypeInt,
            self._totalNumberTimeSteps,
            f77FileInput,
            self._fullOutputInputFile)

        self._numberLoadHistories = lithomop3d.scan_hist(
            f77FileInput,
            self._loadHistoryInputFile)

        self._numberMaterials = matinfo.readprop(self._materialPropertiesInputFile)

        self._propertyList = matinfo.propertyList
        self._propertyListIndex = matinfo.propertyIndex
        self._materialModel = matinfo.materialModel
        self._propertyListSize = len(self._propertyList)
        self._pointerToListArrayPropertyList = lithomop3d.doubleListToArray(
            self._propertyList)
        self._memorySize += self._propertyListSize*self._doubleSize
        self._pointerToListArrayPropertyListIndex = lithomop3d.intListToArray(
            self._propertyListIndex)
        self._memorySize += self._numberMaterials*self._intSize
        self._pointerToListArrayMaterialModel = lithomop3d.intListToArray(
            self._materialModel)
        self._memorySize += self._numberMaterials*self._intSize

        # At present, we assume that the number of element families is equal to
        # the number of material types used, since only one volume element type at a
        # time is allowed.
        self._numberAllowedVolumeElementTypes = 1
        self._maxNumberVolumeElementFamilies = self._numberAllowedVolumeElementTypes* \
                                               self._numberMaterials

        self._pointerToVolumeElementFamilyList = lithomop3d.allocateInt(
            3*self._maxNumberVolumeElementFamilies)
        self._memorySize += 3*self._maxNumberVolumeElementFamilies*self._intSize

        self._volumeElementDimens = lithomop3d.scan_connect(
            self._pointerToListArrayNumberElementNodesBase,
            self._pointerToMaterialModelInfo,
            self._pointerToListArrayMaterialModel,
            self._pointerToVolumeElementFamilyList,
            self._maxNumberVolumeElementFamilies,
	    self._numberMaterials,
            f77FileInput,
            self._connectivityInputFile)

        self._numberVolumeElements = self._volumeElementDimens[0]
        self._numberVolumeElementFamilies = self._volumeElementDimens[1]
        self._volumeElementType = self._volumeElementDimens[2]

        self._pointerToListArrayMaterialModel = None
        self._pointerToListArrayPropertyListIndex = None
        self._memorySize -= 2*self._numberMaterials*self._intSize

        # self._numberPrestressEntries = lithomop3d.scan_prestr(
        #     self._stateVariableDimension,
        #     self._numberPrestressGaussPoints,
        #     self._numberElements,
        #     self._prestressAutoComputeInt,
        #     f77FileInput,
        #     self._prestressInputFile)

        # self._numberTractionBc = lithomop3d.scan_traction(
        #     self._numberElementNodes,
        #     self._numberTractionDirections,
        #     self._tractionBcUnits,
        #     f77FileInput,
        #     self._tractionInputFile)

        if self._numberTractionBc != 0:
        #     self._tractionBcScaleString = \
        #                                 1.0*uparser.parse(string.strip(self._tractionBcUnits))
        #     self._tractionBcScaleFactor = \
        #                                 self._tractionBcScaleString/pyre.units.SI.pascal
            self._tractionFlag = 1

        self._numberSplitNodeEntries = lithomop3d.scan_split(
            f77FileInput,
            self._splitNodeInputFile)

        self._numberSlipperyNodeEntries = lithomop3d.scan_slip(
            f77FileInput,
            self._slipperyNodeInputFile)

        self._numberDifferentialForceEntries = lithomop3d.scan_diff(
            self._numberSlipperyNodeEntries,
            f77FileInput,
            self._differentialForceInputFile)

        self._slipperyWinklerInfo = lithomop3d.scan_winkx(
            self._numberSlipperyNodeEntries,
            f77FileInput,
            self._slipperyWinklerInputFile)
        self._numberSlipperyWinklerEntries = self._slipperyWinklerInfo[0]
        self._numberSlipperyWinklerForces = self._slipperyWinklerInfo[1]

	print ""
        print "Hello from lm3dscan._init (end)!"

        return


    class CanNotOpenInputOutputFilesError(Exception):
        
        def __init__(self):
            self._ioErrors = {}
            self._ioErrorProtos = {}
            self._fatalIOErrors = 0
        
        def openFailed(self, trait, descriptor, value, error, category):
            """Open failed for an I/O file property."""
            errno = error[0]
            if not self._ioErrors.has_key(errno):
                self._ioErrors[errno] = {}
                proto = IOError(error[0], error[1]) # omit filename
                self._ioErrorProtos[errno] = proto
            from copy import copy
            descriptor = copy(descriptor)
            descriptor.origValue = descriptor.value
            descriptor.value = value
            self._ioErrors[errno][trait.name] = (error, descriptor, category)
            self._fatalIOErrors = self._fatalIOErrors + category.fatalPoints
            return

        def fatalIOErrors(self): return self._fatalIOErrors

        def __str__(self): return "Errors opening input/output files!"
    
        def report(self, stream):
            errnos = self._ioErrors.keys()
            errnos.sort()
            cw = [4, 4, 30, 15, 10, 10] # column widths
            ch = ("", "", "property", "value", "from", "") # column headers
            for errno in errnos:
                propertyNames = self._ioErrors[errno].keys()
                for name in propertyNames:
                    error, descriptor, category = self._ioErrors[errno][name]
                    valueLen = len(descriptor.value)
                    if valueLen > cw[3]:
                        cw[3] = valueLen
            for errno in errnos:
                print >> stream, "".ljust(cw[0]), self._ioErrorProtos[errno]
                for column in xrange(0, len(ch)):
                    print >> stream, ch[column].ljust(cw[column]),
                print >> stream
                for column in xrange(0, len(ch)):
                    print >> stream, ("-" * len(ch[column])).ljust(cw[column]),
                print >> stream
                propertyNames = self._ioErrors[errno].keys()
                propertyNames.sort()
                for name in propertyNames:
                    error, descriptor, category = self._ioErrors[errno][name]
                    print >> stream, \
                          "".ljust(cw[0]), \
                          "".ljust(cw[1]), \
                          name.ljust(cw[2]), \
                          descriptor.value.ljust(cw[3]), \
                          str(descriptor.locator).ljust(cw[4]), \
                          (category.label and ("(%s)" % category.label).ljust(cw[5]) or "")
                print >> stream
            return

    class IOFileCategory(object):
        def __init__(self, tryOpen, fatalPoints, label):
            self.tryOpen = tryOpen
            self.fatalPoints = fatalPoints
            self.label = label
    
    def macroString(self, trait):
        from pyre.util import expandMacros
        class InventoryAdapter(object):
            def __init__(self, inventory):
                self.inventory = inventory
            def __getitem__(self, key):
                return expandMacros(str(self.inventory.getTraitValue(key)), self)
        descriptor = self.inventory.getTraitDescriptor(trait.name)
        return expandMacros(descriptor.value, InventoryAdapter(self.inventory))

    def ioFileStream(self, trait, flags, mode, category):
        value = self.macroString(trait)
        stream = None
        if category.tryOpen:
            try:
                stream = os.fdopen(os.open(value, flags), mode)
            except (OSError, IOError), error:
                descriptor = self.inventory.getTraitDescriptor(trait.name)
                self._summaryIOError.openFailed(trait, descriptor, value, error, category)
        return value, stream

    def inputFile(self, trait, category):
        value, stream = self.ioFileStream(trait,os. O_RDONLY, "r", category)
        if stream is not None:
            stream.close()
        return value
    
    def inputFileStream(self, trait, category): return self.ioFileStream(trait, os.O_RDONLY, "r", category)[1]
    
    def outputFile(self, trait, category):
        value, stream = self.ioFileStream(trait, os.O_WRONLY|os.O_CREAT|os.O_EXCL, "w", category)
        if stream is not None:
            stream.close()
            os.remove(value)
        return value


    class Inventory(Component.Inventory):

        import pyre.inventory
        MacroString = pyre.inventory.str
        OutputFile = pyre.inventory.str
        InputFile = pyre.inventory.str

        title = pyre.inventory.str("title",
                                   default="Patchtest 1 for linear hex elements, full quadrature.")
        fileRoot = pyre.inventory.str("fileRoot", default="pt1")
        
        keywordEqualsValueFile = InputFile("keywordEqualsValueFile",default="${fileRoot}.keyval")
        asciiOutputFile = OutputFile("asciiOutputFile",default="${fileRoot}.ascii")
        plotOutputFile = OutputFile("plotOutputFile",default="${fileRoot}.plot")
        ucdOutputRoot = MacroString("ucdOutputRoot",default="${fileRoot}")
        coordinateInputFile = InputFile("coordinateInputFile",default="${fileRoot}.coord")
        bcInputFile = InputFile("bcInputFile",default="${fileRoot}.bc")
        winklerInputFile = InputFile("winklerInputFile",default="${fileRoot}.wink")
        rotationInputFile = InputFile("rotationInputFile",default="${fileRoot}.skew")
        timeStepInputFile = InputFile("timeStepInputFile",default="${fileRoot}.time")
        fullOutputInputFile = InputFile("fullOutputInputFile",default="${fileRoot}.fuldat")
        stateVariableInputFile = InputFile("stateVariableInputFile",default="${fileRoot}.statevar")
        loadHistoryInputFile = InputFile("loadHistoryInputFile",default="${fileRoot}.hist")
        materialPropertiesInputFile = InputFile("materialPropertiesInputFile",default="${fileRoot}.prop")
        materialHistoryInputFile = InputFile("materialHistoryInputFile",default="${fileRoot}.mhist")
        connectivityInputFile = InputFile("connectivityInputFile",default="${fileRoot}.connect")
        prestressInputFile = InputFile("prestressInputFile",default="${fileRoot}.prestr")
        tractionInputFile = InputFile("tractionInputFile",default="${fileRoot}.tract")
        splitNodeInputFile = InputFile("splitNodeInputFile",default="${fileRoot}.split")
        slipperyNodeInputFile = InputFile("slipperyNodeInputFile",default="${fileRoot}.slip")
        differentialForceInputFile = InputFile("differentialForceInputFile",default="${fileRoot}.diff")
        slipperyWinklerInputFile = InputFile("slipperyWinklerInputFile",default="${fileRoot}.winkx")
        
        asciiOutput = pyre.inventory.str("asciiOutput",default="echo")
        asciiOutput.validator = pyre.inventory.choice(["none","echo","full"])
        plotOutput = pyre.inventory.str("plotOutput",default="none")
        plotOutput.validator = pyre.inventory.choice(["none","ascii","binary"])
        ucdOutput = pyre.inventory.str("ucdOutput",default=None)
        ucdOutput.validator = pyre.inventory.choice(["none","ascii","binary"])
        analysisType = pyre.inventory.str("analysisType",default="fullSolution")
        analysisType.validator = pyre.inventory.choice(["dataCheck","stiffnessFactor",
                                                        "elasticSolution","fullSolution"])
        debuggingOutput = pyre.inventory.bool("debuggingOutput",default=False)
        autoRotateSlipperyNodes = pyre.inventory.bool("autoRotateSlipperyNodes",default=True)
        numberCycles = pyre.inventory.int("numberCycles",default=1)


# version
# $Id: Lithomop3d_scan.py,v 1.19 2005/06/24 20:22:03 willic3 Exp $

# End of file 
