#!/bin/bash

declare -a num_sessions=([0]=25 [1]=50 [2]=100 [3]=200 [4]=400 [5]=800 [6]=1600)
declare -a inter_arr_time=([0]=e0.40 [1]=e0.20 [2]=e0.10 [3]=e0.05 [4]=e0.025 [5]=e0.0125 [6]=e0.00625)

for i in {0..6}
do
  
  for j in {0..4}
  do
  
    ssh ubuntu@100.20.48.103 <<EOF
sudo ~/CSC570/collectlcpu.sh perfdata_new_${i}_${j}.txt &
sudo ~/CSC570/sar.sh netdata_new_${i}_${j}.txt &
exit
EOF
    
    echo "STARTING HTTPERF"
    httperf --server 100.20.48.103 --port 80 --num-conns ${num_sessions[$i]} --period ${inter_arr_time[$i]} > ~/CSC570/responsetimes/output_new_${i}_${j}.txt
    
    ssh ubuntu@100.20.48.103 <<EOF
sudo killall collectl
sudo killall sar
exit
EOF
      
    
done


done
