#!/bin/bash

#########################################################################################
#
#   ATTENTION: Automatically created by cmake in 'ics_create_local_shell_script()'
#
#   Manual modifications in this file will be overwritten!
#
#########################################################################################

# get location of this script
sourceDir=$BASH_SOURCE
runDir=$0

if [[ $sourceDir != $runDir ]]; then
    echoc BRED "ERROR: You must run this script."
    return 1
fi

sourceDir=$(cd $(dirname $sourceDir); pwd)

exeNamePath="../build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default/avr_sim_poti_led_template"

# convert cmake array to bash array
paths=""
IFS=';' read -r -a paths <<< "$paths"

#echo $exeNamePath
#echo ${paths[@]}

# build and export load library path
len=${#paths[@]}
for (( i=0; i<len; i++ ))
do
    path=${paths[${i}]}

    if [ -z $loadLibPaths ]; then
        loadLibPaths+=$path
    else
        loadLibPaths+=:$path
    fi
done

if [ ! -z $loadLibPaths ]; then
    export LD_LIBRARY_PATH=$loadLibPaths
fi

#echo $loadLibPaths

# show which libraries are used
ldd $sourceDir/$exeNamePath

# run executable
$sourceDir/$exeNamePath $@

