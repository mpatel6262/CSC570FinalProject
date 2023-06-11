#!/bin/bash

declare -a num_sessions=([0]=720 [1]=360 [2]=180 [3]=90 [4]=45 [5]=600 [6]=480)
declare -a inter_arr_time=([0]=e0.05 [1]=e0.10 [2]=e0.20 [3]=e0.40 [4]=e0.80 [5]=e0.06 [6]=e0.075)

for i in {3..4}
do
  
  for j in {0..4}
  do
  
    ssh -i Activity3Key.pem ubuntu@54.185.194.21 <<EOF
    #sudo /home/ubuntu/engg_533/setmysql.sh&
sudo /home/ubuntu/engg_533/collectlcpu.sh perfdata_new_${i}_${j}.txt &
sudo /home/ubuntu/engg_533/sar.sh netdata_new_${i}_${j}.txt &
sudo service apache2 start
exit
EOF
    
    echo "STARTING HTTPERF"
    httperf --server 54.185.194.21 --port 80 --wsesslog ${num_sessions[$i]},0,input.txt --period ${inter_arr_time[$i]} --dead=36 --rfile=/home/ubuntu/engg_533/responsetimes/rfile_new_${i}_${j}.txt > /home/ubuntu/engg_533/responsetimes/output_new_${i}_${j}.txt
    
    ssh -i Activity3Key.pem ubuntu@54.185.194.21 <<EOF
sudo killall collectl
sudo killall sar
sudo service apache2 stop
exit
EOF
      
    
done


done
