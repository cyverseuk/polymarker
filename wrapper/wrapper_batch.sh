#!/bin/bash

rmthis=`ls`
echo ${rmthis}

locpFile="${pFile}"
locPRIPSR="${PRIPSR}"
locPRIMS="${PRILACC}"
locPRILB="${PRILB}"
locPRINR="${PRINR}"

if [ -z "${locpFile}" ]
  then
    if [ -z "${locPRIPSR}" ] && [ -z "${locPRIMS}" ] && [ -z "${locPRILACC}" ] && [ -z "${locPRILB}" ] && [ -z "${locPRINR}" ]
      then
        PRIFILE=
      else
        if [ ! -z "${locPRIPSR}" ]
          then
            echo PRIMER_PRODUCT_SIZE_RANGE=${locPRIPSR} >> primer3.txt
        fi
        if [ ! -z "${locPRIMS}" ]
          then
            echo PRIMER_MAX_SIZE=${locPRIMS} >> primer3.txt
        fi
        if [ ! -z "${locPRILACC}" ]
          then
            echo PRIMER_LIB_AMBIGUITY_CODES_CONSENSUS=${locPRILACC} >> primer3.txt
        fi
        if [ ! -z "${locPRILB}" ]
          then
            echo PRIMER_LIBERAL_BASE=${locPRILB} >> primer3.txt
        fi
        if [ ! -z "${locPRINR}" ]
          then
            echo PRIMER_NUM_RETURN=${locPRINR} >> primer3.txt
        fi
        PRIFILE="--primer_3_preferences primer3.txt"
    fi
  else
    PRIFILE=${locpFile}
fi

ARGS=" ${cFile} ${mFile} ${sFile} ${tFile} ${ref} ${GENOMES} ${MINID} ${MODEL} ${ARM} ${PRIFILE} --output output"

docker run -v `pwd`:/data cyverseuk/polymarker:v0.7.3 /bin/bash -c "source ../.bashrc; polymarker.rb ${ARGS}";

rmthis=`echo ${rmthis} | sed s/.*\.out// -`
rmthis=`echo ${rmthis} | sed s/.*\.err// -`
rm --verbose ${rmthis}
