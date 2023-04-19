#!/bin/bash

parameters()

{

filePath="/home/dilk_devendra/scripts/PodsDetails/PodsInfo/relevant.txt"
#declaring parameter values to variables
StartT=$(cat "${filePath}"| cut -d ',' -f1)
StopT=$(cat "${filePath}"| cut -d ',' -f2)
Mservice=$(cat "${filePath}"| cut -d ',' -f3)
MaxPod=$(cat "${filePath}"| cut -d ',' -f4)
MaxX=$(cat "${filePath}"| cut -d ',' -f5)
status=$(cat "${filePath}"| cut -d ',' -f6)
echo "Starting Time is, $StartT"
echo "Stopping Time is, $StopT"
echo "Mservice is, $Mservice"
echo "MaxPod is, $MaxPod"
echo "MaxX is, $MaxX"
echo "Status is, $status"
}


#removing present txt files
rm -rf /home/dilk_devendra/scripts/PodsDetails/PodsInfo/relevant.txt
touch /home/dilk_devendra/scripts/PodsDetails/PodsInfo/relevant.txt

#currentT=$(date +"%Y-%m-%dT%H:%M:%S%z")
currentT=2022-11-02T01:05:00+0530

filename="/home/dilk_devendra/scripts/PodsDetails/PodsInfo/123.csv"
tmpfile="/home/dilk_devendra/scripts/PodsDetails/PodsInfo/123_tmp.csv"

while IFS=',' read -r starttime EndTime microservice maxPOD maxX status
do
  if [[ ! "${starttime}" > "${currentT}" && "${currentT}" < "${EndTime}" ]]; then
    echo "${starttime},${EndTime},${microservice},${maxPOD},${maxX},Done" >> "${tmpfile}"
    echo "${starttime},${EndTime},${microservice},${maxPOD},${maxX},Done" >> /home/dilk_devendra/scripts/PodsDetails/PodsInfo/relevant.txt
    parameters
  else
    echo "${starttime},${EndTime},${microservice},${maxPOD},${maxX},${status}" >> "${tmpfile}"
  fi
done < "${filename}"

mv "${tmpfile}" "${filename}"
