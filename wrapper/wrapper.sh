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
CFILE=(${cFile})
CFILE=${CFILE[@]:1}
MFILE=(${mFile})
MFILE=${MFILE[@]:1}
SFILE=(${sFile})
SFILE=${SFILE[@]:1}
TFILE=(${tFile})
TFILE=${TFILE[@]:1}
REF=(${ref})
REF=${REF[@]:1}
PRIFILE=(${PRIFILE})
PRIFILE=${PRIFILE[@]:1}
INPUTS=" ${CFILE}, ${MFILE}, ${SFILE}, ${TFILE}, ${REF}, ${PRIFILE}"
echo ${ARGS}

echo  universe                = docker >> lib/condorSubmitEdit.htc
echo docker_image            = cyverseuk/polymarker:v0.7.3 >> lib/condorSubmitEdit.htc
echo executable               = ./launch.sh >> lib/condorSubmitEdit.htc
echo arguments				= ${ARGS} >> lib/condorSubmitEdit.htc
echo transfer_input_files = ${INPUTS} launch.sh >> lib/condorSubmitEdit.htc
echo transfer_output_files = output >> lib/condorSubmitEdit.htc
cat lib/condorSubmit.htc >> lib/condorSubmitEdit.htc

less lib/condorSubmitEdit.htc

jobid=`condor_submit lib/condorSubmitEdit.htc`
jobid=`echo $jobid | sed -e 's/Sub.*uster //'`
jobid=`echo $jobid | sed -e 's/\.//'`

#echo $jobid

#echo going to monitor job $jobid
condor_tail -f $jobid

exit 0
