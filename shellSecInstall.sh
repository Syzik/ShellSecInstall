#!/bin/bash
#--------------- Process to add a Tools -----------------------

######## Add to listTools : ########
## to add a git : git:nameTool:gitAdresse
## to add a release : wget:nameTool:releaseAdresse
## to add an apt packet : apt:nameTool:aptPacketName
## to add specific process to install tool : install:nameTool:install+nameTools > make a function named install+nameTools > code process

#--------------------------------------------------------------

listTools=( "" "install:All:installAll" "git:Nishang:https://github.com/samratashok/nishang" "git:Impacket:https://github.com/SecureAuthCorp/impacket.git" "git:ImpacketStaticBinary:https://github.com/ropnop/impacket_static_binaries.git" "install:Lazagne:installLazagne" "git:CrackMapExec:https://github.com/byt3bl33d3r/CrackMapExec.git" "git:Mimikatz:https://github.com/gentilkiwi/mimikatz.git" "git:ASRPRoast:https://github.com/HarmJ0y/ASREPRoast.git" "install:Rpivot:installRpivot" "git:Rubeus:https://github.com/GhostPack/Rubeus.git" "git:SharpHound:https://github.com/BloodHoundAD/SharpHound.git" "install:BloodHound:installBloodHound" "install:Kekeo:installKekeo" "install:Kerbrute:installKerbrute" "apt:Sshuttle:sshuttle" "git:LinEnum:https://github.com/rebootuser/LinEnum.git" "git:PayloadAllTheThings:https://github.com/swisskyrepo/PayloadsAllTheThings.git" "git:Nullinux:https://github.com/m8r0wn/nullinux.git" "git:Sn1per:https://github.com/1N3/Sn1per.git" "git:SecLists:https://github.com/danielmiessler/SecLists.git" "git:Grouper2:https://github.com/l0ss/Grouper2.git" "git:GpoCheck:https://github.com/aurel26/gpocheck.git" "install:cme:installCme" "install:Empire:installEmpire" "install:ticket_converter:installTicketConverter")

orange='\e[0;33m'
neutre='\e[0;m'
bleu='\e[1;34m'
vert='\e[1;32m'
rouge='\e[0;31m'
tab='\t\t\t'

main()
{
while true
do
    syzik
    checkRoot
    showMenu
    readOptions
done
}

checkRoot()
{
if [ `whoami` != 'root' ]; then
   {
       echo -e "${tab}${rouge}Please run as root bitch\033[0m"
       exit
   } 
else
    {
	echo -e "${tab}${vert}Well u are root let's start\033[0m"
	cd /opt/
    }
fi
}

showMenu() {
    echo -e "${tab} ~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo -e "${tab}  I N S T A L L - M E N U"
    echo -e "${tab} ~~~~~~~~~~~~~~~~~~~~~~~~~"
    for ((i=1; i < ${#listTools[@]}; i++)); do
	echo  -e "${tab}    $i. Install $(echo -e ${listTools[i]} | cut -d: -f2)"
    done
    echo  -e "${tab}    0. Quit "
    getTabMaxSize
}

getTabMaxSize() {
    max=0
    for tools in "${listTools[@]}"; do 
	((max=max+1))
    done
}

readOptions(){
local choice
read -p "Enter choice [ 0 - $((max-1))] " choice
case $choice in
    $choice) choiceSelected $choice ;;
    *) echo -e "${rouge}Error..." && sleep 1
esac
}

clone(){
    git clone https:$1
}

apt(){
    apt-get install $1
}

get(){
    wget https:$1
}

choiceSelected(){
    if [ "$1" -eq 0 ]; then
	 exit 0
    else
	howToInstall $1
    fi
}

howToInstall(){
    if [ $(echo -e ${listTools[$1]} | cut -d: -f1) == "git" ]; then
	clone $(echo -e ${listTools[$1]} | cut -d: -f4)
    elif [ $(echo -e ${listTools[$1]} | cut -d: -f1) == "wget" ]; then
	get $(echo -e ${listTools[$1]} | cut -d: -f4)
    elif [ $(echo -e ${listTools[$1]} | cut -d: -f1) == "apt" ]; then
	apt $(echo -e ${listTools[$1]} | cut -d: -f3)
    elif [ $(echo -e ${listTools[$1]} | cut -d: -f1) == "install" ]; then
	$(echo -e ${listTools[$1]} | cut -d: -f3)
    else
	echo -e "${rouge}Error Format" && exit 0
    fi
}

installAll(){
    for ((i=2; i < ${#listTools[@]}; i++)); do
	howToInstall $i
    done
}

#Rpivot
installRpivot(){
clone $(echo "//github.com/klsecservices/rpivot")
cd rpivot
wget $(echo "https://github.com/klsecservices/rpivot/releases/download/v1.0/client.exe")
cd /opt
}

# Empire
installEmpire(){
clone $(echo "//github.com/EmpireProject/Empire.git")
cd /opt/Empire/setup/
./install.sh
cd /opt
}

# Lazagne
installLazagne(){
clone $(echo "//github.com/AlessandroZ/LaZagne.git")
cd /opt/LaZagne/Windows/
wget $(echo "http://github.com/AlessandroZ/LaZagne/releases/download/v2.4.2/lazagne.exe")
}

# BloodHound
installBloodHound(){
wget $(echo "https://github.com/BloodHoundAD/BloodHound/releases/download/2.1.0/BloodHound-linux-x64.zip")
unzip BloodHound-linux-x64.zip
rm BloodHound-linux-x64.zip
clone $(echo "//github.com/fox-it/BloodHound.py.git")
}

# CME
installCme(){
cd /opt/
apt-get install -y libssl-dev libffi-dev python-dev build-essential
pip install --user pipenv
git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec
cd CrackMapExec && pipenv install
pipenv shell
python setup.py install
cd /opt/
}

# Kekeo
installKekeo(){
get $(echo "https://github.com/gentilkiwi/kekeo/releases/download/2.2.0-20190407/kekeo.zip")
unzip kekeo.zip
mkdir kekeo
mv x64 kekeoX64 && mv Win32 kekeoWin32 && mv samba kekeoSamba
rm kekeo.zip
mkdir kekeo; mv kekeo* ./kekeo; mv README.md ./kekeo
rm kekeo.zip && rm README.md
}

# Kerbrute
installKerbrute(){
wget $(echo "https://github.com/ropnop/kerbrute/releases/download/v1.0.1/kerbrute_linux_amd64")
chmod 764 kerbrute_linux_amd64
}

# Ticket_Converter
installTicketConverter(){
clone $(echo "//github.com/Zer1t0/ticket_converter")
cd ticket_converter
pip install -r requirements.txt
chmod 654 ticket_convert.py
cd /opt
}

syzik(){
echo -e "${orange}                                                                                                
      *////////               
    //////////////         
  *////*,..*/////        
  ///////////*             _____ _          _ _  _____           _____           _        _ _  
  ///////////,            / ____| |        | | |/ ____|         |_   _|         | |      | | | 
  .////   ./    ///      | (___ | |__   ___| | | (___   ___  ___  | |  _ __  ___| |_ __ _| | | 
    .////   /             \___ \|  _ \ / _ \ | |\___ \ / _ \/ __| | | |  _ \/ __| __/ _' | | |
     ////  ///             ___) | | | |  __/ | |____) |  __/ (__ _| |_| | | \__ \ || (_| | | |  
           ///////.      |_____/|_| |_|\___|_|_|_____/ \___|\___|_____|_| |_|___/\__\__'_|_|_| 
           //////./            
            //////*           
             ,////            
                /,	    "
}

main

