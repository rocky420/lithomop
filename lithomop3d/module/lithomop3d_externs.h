// -*- C++ -*-
// 
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//  Lithomop3d by Charles A. Williams
//  Copyright (c) 2003-2005 Rensselaer Polytechnic Institute
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE  SOFTWARE IS  PROVIDED  "AS  IS", WITHOUT  WARRANTY  OF ANY  KIND,
//  EXPRESS OR  IMPLIED, INCLUDING  BUT NOT LIMITED  TO THE  WARRANTIES OF
//  MERCHANTABILITY,    FITNESS    FOR    A   PARTICULAR    PURPOSE    AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE,  ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// 

#if !defined(lithomop3d_externs_h)
#define lithomop3d_externs_h

#include <stddef.h>

#define assign_wink_f FC_FUNC_(assign_wink, ASSIGN_WINK)
#define autoprestr_f FC_FUNC(autoprestr, AUTOPRESTR)
#define cmp_stiffsz_f FC_FUNC_(cmp_stiffsz, CMP_STIFFSZ)
#define create_id_f FC_FUNC_(create_id, CREATE_ID)
#define elastc_f FC_FUNC(elastc, ELASTC)
#define id_split_f FC_FUNC_(id_split, ID_SPLIT)
#define lnklst_f FC_FUNC(lnklst, LNKLST)
#define local_f FC_FUNC(local, LOCAL)
#define localf_f FC_FUNC(localf, LOCALF)
#define localx_f FC_FUNC(localx, LOCALX)
#define makemsr_f FC_FUNC(makemsr, MAKEMSR)
#define matmod_def_f FC_FUNC_(matmod_def, MATMOD_DEF)
#define nfind_f FC_FUNC(nfind, NFIND)
#define preshape_f FC_FUNC(preshape, PRESHAPE)
#define read_bc_f FC_FUNC_(read_bc, READ_BC)
#define read_connect_f FC_FUNC_(read_connect, READ_CONNECT)
#define read_coords_f FC_FUNC_(read_coords, READ_COORDS)
#define read_diff_f FC_FUNC_(read_diff, READ_DIFF)
#define read_fuldat_f FC_FUNC_(read_fuldat, READ_FULDAT)
#define read_hist_f FC_FUNC_(read_hist, READ_HIST)
// #define read_mathist_f FC_FUNC_(read_mathist, READ_MATHIST)
// #define read_prestr_f FC_FUNC_(read_prestr, READ_PRESTR)
#define read_skew_f FC_FUNC_(read_skew, READ_SKEW)
#define read_slip_f FC_FUNC_(read_slip, READ_SLIP)
#define read_split_f FC_FUNC_(read_split, READ_SPLIT)
#define read_stateout_f FC_FUNC_(read_stateout, READ_STATEOUT)
#define read_timdat_f FC_FUNC_(read_timdat, READ_TIMDAT)
// #define read_traction_f FC_FUNC_(read_traction, READ_TRACTION)
#define read_wink_f FC_FUNC_(read_wink, READ_WINK)
// #define read_winkx_f FC_FUNC_(read_winkx, READ_WINKX)
#define scan_bc_f FC_FUNC_(scan_bc, SCAN_BC)
#define scan_connect_f FC_FUNC_(scan_connect, SCAN_CONNECT)
#define scan_coords_f FC_FUNC_(scan_coords, SCAN_COORDS)
#define scan_diff_f FC_FUNC_(scan_diff, SCAN_DIFF)
#define scan_fuldat_f FC_FUNC_(scan_fuldat, SCAN_FULDAT)
#define scan_hist_f FC_FUNC_(scan_hist, SCAN_HIST)
// #define scan_prestr_f FC_FUNC_(scan_prestr, SCAN_PRESTR)
#define scan_skew_f FC_FUNC_(scan_skew, SCAN_SKEW)
#define scan_slip_f FC_FUNC_(scan_slip, SCAN_SLIP)
#define scan_split_f FC_FUNC_(scan_split, SCAN_SPLIT)
#define scan_timdat_f FC_FUNC_(scan_timdat, SCAN_TIMDAT)
// #define scan_traction_f FC_FUNC_(scan_traction, SCAN_TRACTION)
#define scan_wink_f FC_FUNC_(scan_wink, SCAN_WINK)
#define scan_winkx_f FC_FUNC_(scan_winkx, SCAN_WINKX)
#define sort_elements_f FC_FUNC_(sort_elements, SORT_ELEMENTS)
#define sort_slip_nodes_f FC_FUNC_(sort_slip_nodes, SORT_SLIP_NODES)
#define sort_split_nodes_f FC_FUNC_(sort_split_nodes, SORT_SPLIT_NODES)
#define try_binio_f FC_FUNC_(try_binio, TRY_BINIO)
#define viscos_f FC_FUNC(viscos, VISCOS)
#define write_bc_f FC_FUNC_(write_bc, WRITE_BC)
#define write_connect_f FC_FUNC_(write_connect, WRITE_CONNECT)
#define write_coords_f FC_FUNC_(write_coords, WRITE_COORDS)
#define write_diff_f FC_FUNC_(write_diff, WRITE_DIFF)
#define write_element_info_f FC_FUNC_(write_element_info, WRITE_ELEMENT_INFO)
#define write_fuldat_f FC_FUNC_(write_fuldat, WRITE_FULDAT)
#define write_global_info_f FC_FUNC_(write_global_info, WRITE_GLOBAL_INFO)
#define write_hist_f FC_FUNC_(write_hist, WRITE_HIST)
#define write_props_f FC_FUNC_(write_props, WRITE_PROPS)
#define write_skew_f FC_FUNC_(write_skew, WRITE_SKEW)
#define write_slip_f FC_FUNC_(write_slip, WRITE_SLIP)
#define write_sparse_info_f FC_FUNC_(write_sparse_info, WRITE_SPARSE_INFO)
#define write_split_f FC_FUNC_(write_split, WRITE_SPLIT)
#define write_split_plot_f FC_FUNC_(write_split_plot, WRITE_SPLIT_PLOT)
#define write_stateout_f FC_FUNC_(write_stateout, WRITE_STATEOUT)
#define write_strscomp_f FC_FUNC_(write_strscomp, WRITE_STRSCOMP)
#define write_subiter_f FC_FUNC_(write_subiter, WRITE_SUBITER)
#define write_timdat_f FC_FUNC_(write_timdat, WRITE_TIMDAT)
#define write_ucd_mesh_f FC_FUNC_(write_ucd_mesh, WRITE_UCD_MESH)
#define write_wink_f FC_FUNC_(write_wink, WRITE_WINK)
#define write_winkx_f FC_FUNC_(write_winkx, WRITE_WINKX)

extern "C" {

  void assign_wink_f(double *,
		     double *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *);

  void autoprestr_f(Mat *,             // sparse
		    double *,          // force
		    double *,
		    double *,
		    double *,
		    double *,
		    double *,
		    double *,
		    double *,
		    double *,
		    double *,
		    int *,
		    double *,
		    double *,          // global
		    double *,
		    double *,
		    double *,
		    int *,
		    int *,
		    double *,
		    int *,
		    int *,
		    int *,             // bc
		    double *,
		    double *,          // slip
		    double *,
		    double *,
		    double *,
		    int *,
		    int *,
		    double *,
		    int *,
		    int *,
		    int *,
		    double *,          // split
		    int *,
		    double *,
		    double *,
		    double *,          // stiff
		    double *,
		    double *,          // element
		    double *,
		    double *,
		    double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,             // traction
		    int *,
		    int *,
		    double *,
		    double *,
		    double *,          // material
		    int *,
		    double *,          // element type
		    double *,
		    double *,
		    int *,
		    double *,          // time data
		    double *,
		    int *,
		    int *,
		    int *,
		    double *,
		    double *,
		    int *,
		    int *,
		    int *,
		    double *,
		    double *,
		    double *,
		    int *,
		    double *,          // iterations
		    double *,          // skew
		    int *,             // i/o info
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,            // files
		    char *,
		    char *,
                    int *,             // PETSc logging
		    int *,
		    int *,             // error codes
		    char *,
		    size_t,               // string lengths
		    size_t,
		    size_t,
		    size_t);

  void cmp_stiffsz_f(int *,
	             int *,
	             int *,
	             int *,
	             int *,
	             int *,
	             int *,
	             int *,
	             char *,size_t);

  void create_id_f(int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *);

  void elastc_f(Mat *,             // sparse
		double *,          // force
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		int *,
		double *,
		double *,          // global
		double *,
		double *,
		double *,
		int *,
		int *,
		double *,
		int *,
		int *,
		int *,             // bc
		double *,
		double *,          // slip
		double *,
		double *,
		double *,
		int *,
		int *,
		double *,
		int *,
		int *,
		int *,
		double *,          // split
		int *,
		double *,
		double *,
		double *,          // stiff
		double *,
		double *,          // element
		double *,
		double *,
		double *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,             // traction
		int *,
		int *,
		double *,
		double *,
		double *,          // material
		int *,
		double *,          // element type
		double *,
		double *,
		int *,
		double *,          // time data
		double *,
		int *,
		int *,
		int *,
		double *,
		double *,
		int *,
		int *,
		int *,
		double *,
		double *,
		double *,
		int *,
		double *,          // iterations
		double *,          // skew
		int *,             // i/o info
		int *,
		int *,
		int *,
		int *,
		char *,            // files
		char *,
		char *,
                int *,            // PETSc logging
                int *,
		int *,             // error codes
		char *,
		size_t,               // string lengths
		size_t,
		size_t,
		size_t);

  void id_split_f(int *,
		  int *,
		  int *,
		  int *,
		  int *);

  void lnklst_f(int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		char *,
		size_t);

  void local_f(int *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *);

  void localf_f(int *,
		int *,
		int *,
		int *,
		int *,
		int *);

  void localx_f(int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *);

  void makemsr_f(Mat *,
		 int *,
		 int *,
		 int *,
		 int *,
		 int *,
		 int *,
		 int *,
		 int *,
		 double *);

  void matmod_def_f(int *);

  void nfind_f(double *,
	       double *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *,
	       int *);

  void preshape_f(double *,
		  double *,
		  double *,
		  int *,
		  int *,
		  int *,
		  int *,
		  int *,
		  char *,size_t);

  void read_bc_f(double*,
		 double*,
		 double*,
		 double*,
		 int *,
		 int *,
		 int *,
		 int *,
		 int *,
		 char *,
		 int *,
		 char *,
		 size_t,
		 size_t);

  void read_connect_f(int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      char *,
		      int *,
		      char *,
		      size_t,
		      size_t);

  void read_coords_f(double*,
		     double*,
		     int *,
		     int *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t);

  void read_diff_f(double*,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void read_fuldat_f(int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t);

  void read_hist_f(double *,
		   double *,
		   int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  // void read_mathist_f(int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      int *,
// 		      char *,
// 		      char *,
// 		      char *,
// 		      int *,
// 		      char *,
// 		      size_t,
// 		      size_t,
// 		      size_t,
// 		      size_t);

  // void read_prestr_f(double *,
		     // double *,
		     // double *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // char *,
		     // char *,
		     // size_t,
		     // size_t);

  void read_skew_f(double *,
		   double *,
		   int *,
		   int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void read_slip_f(int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void read_split_f(double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void read_stateout_f(int *,
		       int *,
		       int *,
		       char *,
		       int *,
		       char *,
		       size_t,
		       size_t);

  void read_timdat_f(double *,
		     double *,
		     double *,
		     double *,
		     double *,
		     double *,
		     double *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t);

  // void read_traction_f(double *,
		       // double *,
		       // double *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // char *,
		       // char *,
		       // size_t,
		       // size_t);

  void read_wink_f(double *,
		   double *,
		   int *,
		   int *,
		   int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

//   void read_winkx_f(double *,
// 		    double *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    int *,
// 		    char *,
// 		    char *,
// 		    int *,
// 		    char *,
// 		    size_t,
// 		    size_t,
// 		    size_t);

  void scan_bc_f(int *,
		 int *,
		 char *,
		 char *,
		 char *,
		 char *,
		 int *,
		 char *,
		 size_t,
		 size_t,
		 size_t,
		 size_t,
		 size_t);

  void scan_connect_f(int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      char *,
		      int *,
		      char *,
		      size_t,
		      size_t);

  void scan_coords_f(int *,
		     int *,
		     char *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t,
		     size_t);

  void scan_diff_f(int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void scan_fuldat_f(int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t);

  void scan_hist_f(int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  // void scan_prestr_f(int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // int *,
		     // char *,size_t);

  void scan_skew_f(int *,
		   int *,
		   char *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t,
		   size_t);

  void scan_slip_f(int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void scan_split_f(int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void scan_timdat_f(int *,
		     int *,
		     int *,
		     char *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t,
		     size_t);

  // void scan_traction_f(int *,
		       // int *,
		       // int *,
		       // int *,
		       // int *,
		       // char *,
		       // char *,
		       // size_t,
		       // size_t);

  void scan_wink_f(int *,
		   int *,
		   int *,
		   char *,
		   int *,
		   char *,
		   size_t,
		   size_t);

  void scan_winkx_f(int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void sort_elements_f(int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       char *,
		       size_t);

  void sort_slip_nodes_f(int *,
		         int *,
		         int *,
		         int *);

  void sort_split_nodes_f(int *,
		          int *,
		          int *,
		          int *);

  void try_binio_f(int *, int *, char *, size_t);

  void viscos_f(Mat *,             // sparse
		double *,          // force
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		double *,
		int *,
		double *,
		double *,          // global
		double *,
		double *,
		double *,
		int *,
		int *,
		double *,
		int *,
		int *,
		int *,             // bc
		double *,
		double *,          // slip
		double *,
		double *,
		double *,
		int *,
		int *,
		double *,
		int *,
		int *,
		int *,
		double *,          // split
		int *,
		double *,
		double *,
		double *,          // stiff
		double *,
		double *,          // element
		double *,
		double *,
		double *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,
		int *,             // traction
		int *,
		int *,
		double *,
		double *,
		double *,          // material
		int *,
		double *,          // element type
		double *,
		double *,
		int *,
		double *,          // time data
		double *,
		int *,
		int *,
		int *,
		double *,
		double *,
		int *,
		int *,
		int *,
		double *,
		double *,
		double *,
		int *,
		double *,          // iterations
		double *,          // skew
		int *,             // i/o info
		int *,
		int *,
		int *,
		int *,
		int *,
		char *,            // files
		char *,
		char *,
                int *,             // PETSC logging
                int *,
		int *,             // error codes
		char *,
		size_t,               // string lengths
		size_t,
		size_t,
		size_t);

  void write_bc_f(double *,
		  int *,
		  int *,
		  int *,
		  int *,
		  char *,
		  int *,
		  char *,
		  size_t,
		  size_t);

  void write_connect_f(int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       int *,
		       char *,
		       char *,
		       int *,
		       char *,
		       size_t,
		       size_t,
		       size_t);

  void write_coords_f(double *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      char *,
		      char *,
		      int *,
		      char *,
		      size_t,
		      size_t,
		      size_t);

  void write_diff_f(double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void write_element_info_f(int *,
			    int *,
			    int *,
			    int *,
			    int *,
			    int *,
			    int *,
			    double *,
			    double *,
			    int *,
			    int *,
			    char *,size_t);

  void write_fuldat_f(int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      char *,
		      char *,
		      int *,
		      char *,
		      size_t,
		      size_t,
		      size_t);

  void write_global_info_f(char *,
			   int *,
			   int *,
			   int *,
			   int *,
			   int *,
			   int *,
			   int *,
			   char *,
			   char *,
			   size_t,
			   size_t,
			   size_t);

  void write_hist_f(double *,
		    double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void write_props_f(double *,
		     double *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t,
		     size_t);

  void write_skew_f(double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void write_slip_f(int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t,
		    size_t);

  void write_sparse_info_f(int *,
			   int *,
			   int *,
			   int *,
			   double *,
			   int *,
			   int *,
			   char *,size_t);

  void write_split_f(double *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t,
		     size_t);

  void write_split_plot_f(int *,
		          int *,
		          int *,
		          int *,
			  char *,size_t);

  void write_stateout_f(int *,
		        int *,
		        int *,
		        int *,
		        int *,
		        int *,
			char *,
			char *,
			int *,
			char *,
			size_t,
			size_t,
			size_t);

  void write_strscomp_f(double *,
			double *,
			double *,
			int *,
			int *,
			char *,size_t);

  void write_subiter_f(int *,
		       int *,
		       int *,
		       char *,size_t);

  void write_timdat_f(double *,
		      double *,
		      double *,
		      double *,
		      double *,
		      double *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      int *,
		      char *,
		      int *,
		      char *,
		      size_t,
		      size_t);

  void write_ucd_mesh_f(double *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	double *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	int *,
		       	char *,size_t);

  void write_wink_f(double *,
		    int *,
		    int *,
		    int *,
		    int *,
		    int *,
		    char *,
		    int *,
		    char *,
		    size_t,
		    size_t);

  void write_winkx_f(double *,
		     int *,
		     int *,
		     int *,
		     int *,
		     int *,
		     char *,
		     int *,
		     char *,
		     size_t,
		     size_t);
}

#endif // lithomop3d_externs_h


// version
// $Id: lithomop3d_externs.h,v 1.21 2005/06/24 20:17:43 willic3 Exp $

// End of file
