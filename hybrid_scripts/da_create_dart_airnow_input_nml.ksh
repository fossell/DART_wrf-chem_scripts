#!/bin/ksh -x
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# $Id: da_create_dart_airnow_input_nml.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
#

#########################################################################
#
# Purpose: Script to create DART/WRF input.nmlfor Ave's 
# iasi_ascii_to_obs_seq fortran format conversion 
#
#########################################################################
#
# CREATE DART/WRF NAMELIST FILE
rm -f create_airnow_obs_nml.nl
touch create_airnow_obs_nml.nl
cat > create_airnow_obs_nml.nl << EOF
&create_airnow_obs_nml
   year0=${NL_YEAR}
   month0=${NL_MONTH}
   day0=${NL_DAY}
   hour0=${NL_HOUR}
   beg_year=${ASIM_MIN_YYYY}
   beg_mon=${ASIM_MIN_MM}
   beg_day=${ASIM_MIN_DD}
   beg_hour=${ASIM_MIN_HH}
   beg_min=${ASIM_MIN_MN}
   beg_sec=${ASIM_MIN_SS}
   end_year=${ASIM_MAX_YYYY}
   end_mon=${ASIM_MAX_MM}
   end_day=${ASIM_MAX_DD}
   end_hour=${ASIM_MAX_HH}
   end_min=${ASIM_MAX_MN}
   end_sec=${ASIM_MAX_SS}
   file_in=${NL_FILENAME}
   lat_mn=${NL_LAT_MN}
   lat_mx=${NL_LAT_MX}
   lon_mn=${NL_LON_MN}
   lon_mx=${NL_LON_MX}
   use_log_co=${NL_USE_LOG_CO}
   use_log_o3=${NL_USE_LOG_O3}
/
EOF
#
rm -f input.nml
touch input.nml
cat > input.nml << EOF
&obs_sequence_nml
   write_binary_obs_sequence   = .false.
/
&obs_kind_nml
/
&assim_model_nml
   write_binary_restart_files  =.true.
/
&model_nml
/
&location_nml
/
&utilities_nml
   TERMLEVEL                   = 1,
   logfilename                 = 'dart_log.out',
/
&preprocess_nml
   input_obs_kind_mod_file     = '../../obs_kind/DEFAULT_obs_kind_mod.F90',
   output_obs_kind_mod_file    = '../../obs_kind/obs_kind_mod.f90',
   input_obs_def_mod_file      = '../../obs_def/DEFAULT_obs_def_mod.F90',
   output_obs_def_mod_file     = '../../obs_def/obs_def_mod.f90',
   input_files                 = '../../obs_def/obs_def_reanalysis_bufr_mod.f90',
                                 '../../obs_def/obs_def_gps_mod.f90',
                                 '../../obs_def/obs_def_eval_mod.f90'
/
&merge_obs_seq_nml
   num_input_files             = 2,
   filename_seq                = 'obs_seq2008022206',obs_seq2008022212',
   filename_out                = 'obs_seq_ncep_2008022212'
/
EOF


#
# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/hybrid_scripts/da_create_dart_airnow_input_nml.ksh $
# $Id: da_create_dart_airnow_input_nml.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
# $Revision: 13133 $
# $Date: 2019-04-25 15:47:54 -0600 (Thu, 25 Apr 2019) $
