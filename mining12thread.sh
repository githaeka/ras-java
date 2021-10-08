#!/bin/bash

######################################################################################################
#### INI JANGAN DIGANTI, AGAR BISA MENJALANKAN VNCSERVER
sudo -u ubuntu vncserver &
sleep 10
######################################################################################################
################## SCRIPT INI BOLEH DI MODIF
sleep 600

##################################### Persiapan one click PKT
cd /home/ubuntu/unzip_server/PKT/

get_openvpn_config=0
#get_openvpn_config=1
if [ $get_openvpn_config -eq 0 ]; then
	while [ $get_openvpn_config -eq 0 ]
	do
		sudo rm -rf config_vpn.txt
		sleep 3
		wget https://raw.githubusercontent.com/Rickyose/unzip_server/main/PKT/config_vpn.txt
		sleep 3
		ip_vps=`curl ifconfig.me`
		dropbox_vpn=`cat config_vpn.txt | grep "$ip_vps" | awk '{print $2}'`
		ada_config_vpn=`cat config_vpn.txt | grep "$ip_vps" | wc -l`
		vpn_sudah_dipakai_5_PC=`cat config_vpn.txt | grep "$dropbox_vpn" | wc -l`
		dummy_vpn=`cat config_vpn.txt | grep "$ip_vps" | awk '{print $2}'`
		if [ $vpn_sudah_dipakai_5_PC -le 5 ] || [ $dummy_vpn -eq 0 ]; then
			if [ $ada_config_vpn -gt 0 ] || [ $dummy_vpn -eq 0 ]; then
				get_openvpn_config=1
			else
				echo "BELUM ADA CONFIG VPN UNTUK VPS INI"
				sleep 10
			fi
		else
			echo "CONFIG VPN SUDAH DIPAKAI 5 VPS ATAU LEBIH"
			sleep 10
		fi
	done

  sudo rm -rf mullvad_openvpn_linux_all_all.zip
  sudo rm -rf mullvad_config_linux
	wget "$dropbox_vpn"
	unzip -o mullvad_openvpn_linux_all_all.zip
	sudo apt-get install openvpn
	rand_vpn_server=`echo $((1 + $RANDOM % 3))`
	if [ $rand_vpn_server -eq 1 ]; then
		vpn_config="mullvad_de_all.conf"
	else
		if [ $rand_vpn_server -eq 2 ]; then
			vpn_config="mullvad_se_all.conf"
		else
			if [ $rand_vpn_server -eq 3 ]; then
				vpn_config="mullvad_gb_all.conf"
			else
			echo ERROR
			fi
		fi
	fi

	add_route="
	route-nopull 
	route srizbi.com 255.255.255.255
	route pool.srizbi.com 255.255.255.255
	route anycast.srizbi.com 255.255.255.255"
	echo "$add_route"
	sudo echo "$add_route" >> /home/ubuntu/unzip_server/PKT/mullvad_config_linux/"$vpn_config"
fi

############################################## Buat start_mining.sh & pkt.sh & start_raptoreum.sh

cd /home/ubuntu/
############################# JANGAN DIHAPUS ######################################
sudo rm -rf /home/ubuntu/unzip_server/PKT/pkt.sh
############################################################################

get_thread_cpu=`echo "Threads/core: $(nproc --all)" |  awk '{print $2}'`

ip_vps=`curl ifconfig.me`
proxy_monolog="`cat /home/ubuntu/unzip_server/PKT/config_vpn.txt | grep $ip_vps | awk '{print $3}'`"
proxy_monolog_2="$proxy_monolog"
no_raptoreum=" "

if [ `cat /home/ubuntu/unzip_server/PKT/config_vpn.txt | grep "$ip_vps" | awk '{print $4}'` -eq 8 ]; then
address="pkt1q4z3jjk5jte7nptuu5qhfqs8vqput6tp0zpa0a3"
openvpn="sudo openvpn --config $vpn_config &"
vcpu_for_pkt=`echo $(($get_thread_cpu / 1))`
no_raptoreum="#"
pkt_config_bash="$proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io"
else
if [ `cat /home/ubuntu/unzip_server/PKT/config_vpn.txt | grep "$ip_vps" | awk '{print $4}'` -eq 3 ]; then
address="pkt1q624jxhvna95ap5sy66kmprvptpn9qntg95ztg8"
openvpn="sudo openvpn --config $vpn_config &"
vcpu_for_pkt=`echo $(($get_thread_cpu / 2))`
pkt_config_bash="$proxy_monolog_2 $proxy_monolog_2 $proxy_monolog_2 http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io"
else
if [ `cat /home/ubuntu/unzip_server/PKT/config_vpn.txt | grep "$ip_vps" | awk '{print $4}'` -eq 2 ]; then
address="pkt1qjaj959tjnm6ht0cu3qr5fvxscg3wflc9afca24"
openvpn="sudo openvpn --config $vpn_config &"
vcpu_for_pkt=`echo $(($get_thread_cpu / 2))`
pkt_config_bash="$proxy_monolog_2 $proxy_monolog_2 http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io"
else
if [ `cat /home/ubuntu/unzip_server/PKT/config_vpn.txt | grep "$ip_vps" | awk '{print $4}'` -eq 1 ]; then
address="pkt1qxw0kwdm2zuale3mq0xhsjeruz6308k02qvl438"
openvpn="sudo openvpn --config $vpn_config &"
vcpu_for_pkt=`echo $(($get_thread_cpu / 2))`
pkt_config_bash="$proxy_monolog_2 http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io"
else
address="pkt1qn74c4e9j4vzq26tfeetdzrukhkpy8dhy5h839k"
openvpn="sudo openvpn --config $vpn_config &"
vcpu_for_pkt=`echo $(($get_thread_cpu / 2))`
pkt_config_bash="http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io"
fi
fi
fi
fi



pkt="#!/bin/bash
while [ 2 -gt 1 ]
do
sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t $vcpu_for_pkt -p $address $pkt_config_bash
sleep 3600
sudo kill $(ps aux | grep "packetcrypt" | awk '{print $2}')
sleep 60
sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t $vcpu_for_pkt -p $address http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io
sleep 3600
sudo kill $(ps aux | grep "packetcrypt" | awk '{print $2}')
sleep 60
done
#sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t $vcpu_for_pkt -p pkt1qxelp07p58k4x2n58yguyu434g2xjw5pfq0vn6x http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io
#sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t 6 -p pkt1qlug4yrrlxe0rh8l4ry56mpgsmnh8a797wjqd8f http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io http://pool.pktpool.io
#sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t 12 -p pkt1qxelp07p58k4x2n58yguyu434g2xjw5pfq0vn6x http://pool.dropstorage.bond/
#sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t 6 -p pkt1qlug4yrrlxe0rh8l4ry56mpgsmnh8a797wjqd8f http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io
#sudo /home/ubuntu/unzip_server/PKT/packetcrypt ann -t 6 -p pkt1qlug4yrrlxe0rh8l4ry56mpgsmnh8a797wjqd8f http://srizbi.00002.config.pktdigger.com http://pool.pkt.world http://pool.pktpool.io"
echo "$pkt"
echo "$pkt" > /home/ubuntu/unzip_server/PKT/pkt.sh
sleep 5
chmod +x /home/ubuntu/unzip_server/PKT/pkt.sh

cd /home/ubuntu/
############################# JANGAN DIHAPUS ######################################
sudo rm -rf /home/ubuntu/unzip_server/Raptoreum/start_raptoreum.sh
###################################################################################
start_raptoreum="#!/bin/sh
if [ ! -f /home/ubuntu/unzip_server/Raptoreum/tune_config ]; then
	sudo apt-get install build-essential automake libssl-dev libcurl4-openssl-dev libjansson-dev libgmp-dev zlib1g-dev libnuma-dev git -y
	cd /home/ubuntu/unzip_server/Raptoreum/
	git clone https://github.com/WyvernTKC/cpuminer-gr-avx2
	cd /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/
	./build.sh
else
	echo sudah intall raptoreum
	sleep 5
fi
sudo sysctl -w vm.nr_hugepages=1280
cd /home/ubuntu/unzip_server/Raptoreum/
sudo bash /home/ubuntu/unzip_server/Raptoreum/randomx_boost.sh
if [ ! -f /home/ubuntu/unzip_server/Raptoreum/tune_config ]; then
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 6 --tune-full -a gr -o stratum+tcp://rtm.suprnova.cc:6273 -u abertdune.abertduneisback
  touch /home/ubuntu/unzip_server/Raptoreum/tune_set_done.txt
else
  sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 6 -a gr -o stratum+tcp://rtm.suprnova.cc:6273 -u abertdune.abertduneisback
fi"
echo "$start_raptoreum"
echo "$start_raptoreum" > /home/ubuntu/unzip_server/Raptoreum/start_raptoreum.sh
sleep 5
chmod +x /home/ubuntu/unzip_server/Raptoreum/start_raptoreum.sh
#sudo /home/ubuntu/unzip_server/Raptoreum/cpuminer-gr-avx2/cpuminer -t 6 -a gr -o stratum+tcp://r-pool.net:3008 -u RMrngF8FbAPDoqz1ruRP9RzewrfMdtd4nR

cd /home/ubuntu/
############################# JANGAN DIHAPUS ######################################
sudo rm -rf /home/ubuntu/start_skripburu2_buru2.sh
###################################################################################
skripburu2_buru2="#!/bin/bash
sudo rm -rf skripburu2
git clone https://github.com/Rickyose/skripburu2
sleep 30
chmod +x /home/ubuntu/skripburu2/buru2.sh
/home/ubuntu/skripburu2/buru2.sh
sleep 30"
echo "$skripburu2_buru2"
echo "$skripburu2_buru2" > /home/ubuntu/start_skripburu2_buru2.sh
sleep 5
chmod +x /home/ubuntu/start_skripburu2_buru2.sh

cd /home/ubuntu/
############################# JANGAN DIHAPUS ######################################
sudo rm -rf /home/ubuntu/start_mining.sh
###################################################################################

start_raptor_pkt="#!/bin/bash
sudo rm -rf skripburu2
git clone https://github.com/Rickyose/skripburu2
sleep 20
chmod +x /home/ubuntu/skripburu2/buru2.sh
bash /home/ubuntu/skripburu2/buru2.sh &
sleep 30
cd /home/ubuntu/unzip_server/PKT/mullvad_config_linux/
$openvpn
sleep 20
cd /home/ubuntu/
sleep 10
bash /home/ubuntu/unzip_server/PKT/pkt.sh &
sleep 30
$no_raptoreum bash /home/ubuntu/unzip_server/Raptoreum/start_raptoreum.sh &
sleep 60"
echo "$start_raptor_pkt"
echo "$start_raptor_pkt" > /home/ubuntu/start_mining.sh
sleep 5
chmod +x /home/ubuntu/start_mining.sh
sleep 10

bash /home/ubuntu/start_mining.sh &
sleep 10




######################################################################################################
#### INI JANGAN DIGANTI, AGAR BISA AUTO REBOOT DAN MENJALANKAN SCRIPT
sleep 24h
sudo reboot
######################################################################################################
