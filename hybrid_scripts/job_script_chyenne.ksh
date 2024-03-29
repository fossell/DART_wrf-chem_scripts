#!/bin/ksh -aeux
#
# DART software - Copyright UCAR. This open source software is provided
# by UCAR, "as is", without charge, subject to all terms of use at
# http://www.image.ucar.edu/DAReS/DART/DART_download
#
# $Id: job_script_chyenne.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
#

export JOBID=$1
export PROJECT_NUMBER=$2
export TIME_LIMIT=$3
export CLASS=$4
export NODES=$5
export CORES=$6
export PROCS=$7
export EXECUTE=$8
#
if [[ -f job.ksh ]]; then rm -rf job.ksh; fi
touch job.ksh
cat << EOF > job.ksh
#!/bin/ksh -aeux
#PBS -N ${JOBID}
#PBS -A ${PROJECT_NUMBER}
#PBS -l walltime=${TIME_LIMIT}
#PBS -q ${CLASS}
#PBS -j oe
#PBS -l select=${NODES}:ncpus=${CORES}:mpiprocs=${PROCS}
mpiexec_mpt ./${EXECUTE}  > index.html 2>&1 
export RC=\$?     
if [[ -f SUCCESS ]]; then rm -rf SUCCESS; fi     
if [[ -f FAILED ]]; then rm -rf FAILED; fi          
if [[ \$RC = 0 ]]; then
   touch SUCCESS
else
   touch FAILED 
   exit
fi
EOF
#
# <next few lines under version control, do not edit>
# $URL: https://svn-dares-dart.cgd.ucar.edu/DART/tags/wrf-chem.r13172/models/wrf_chem/hybrid_scripts/job_script_chyenne.ksh $
# $Id: job_script_chyenne.ksh 13133 2019-04-25 21:47:54Z nancy@ucar.edu $
# $Revision: 13133 $
# $Date: 2019-04-25 15:47:54 -0600 (Thu, 25 Apr 2019) $
