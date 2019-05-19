#!/bin/bash
#--------------- Process to add a Tools -----------------------
#1 -> add a name at the end of listTools
#2 -> if it's a git repo add repos to listGits
#     if it's an apt repos add "install" to listGits name from listTools should be the apt name repo 
#--------------------------------------------------------------

listTools=( "quit" "All" "Nishang" "Impacket" "ImpacketStaticBinary" "Lazagne" "CrackMapExec" "Mimikatz" "ASREPRoast" "Rpivot" "Rubeus" "SharpHound" "BloodHound" "Kekeo" "Kerbrute" "Sshuttle" "LinEnum" "PayloadsAllTheThings" "NulLinux" "Sn1per" "SecLists" )

listGits=( "installQuit" "installAll" "https://github.com/samratashok/nishang" "https://github.com/SecureAuthCorp/impacket.git" "https://github.com/ropnop/impacket_static_binaries.git" "installLazagne" "https://github.com/byt3bl33d3r/CrackMapExec" "https://github.com/gentilkiwi/mimikatz.git" "https://github.com/HarmJ0y/ASREPRoast.git" "https://github.com/klsecservices/rpivot" "https://github.com/GhostPack/Rubeus.git" "https://github.com/BloodHoundAD/SharpHound.git" "installBloodHound" "installKekeo" "installKerbrute" "install" "https://github.com/rebootuser/LinEnum.git" "https://github.com/swisskyrepo/PayloadsAllTheThings.git" "https://github.com/m8r0wn/nullinux.git" "https://github.com/1N3/Sn1per.git" "https://github.com/danielmiessler/SecLists.git")

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
	echo  -e "${tab}    $i. Install ${listTools[i]}"
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
    *) echo -e "${RED}Error...${STD}" && sleep 1
esac
}

clone(){
    git clone $1
}

install(){
    apt-get install $1
}

choiceSelected(){
    if [ "$1" -eq 0 ]; then
	 exit 0
    elif  [ "$1" -eq 1 ]; then
	installAll 
    else
	howToInstall $1
    fi
}

howToInstall(){
    if [ "${listGits[$1]}" == "install" ]; then
	install ${listTools[$1]}
    else
	clone ${listGits[$1]}
    fi
}

installAll(){
    for ((i=1; i < ${#listGits[@]}; i++)); do
	howToInstall $i
    done
}

installJuicyPotatoe(){
    git clone 
}

installLazagne(){
    git clone https://github.com/AlessandroZ/LaZagne.git
    cd /opt/LaZagne/Windows/
    wget https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.2/lazagne.exe
    cd /opt
}

# BloodHound
installBloodHound(){    
    wget https://github.com/BloodHoundAD/BloodHound/releases/download/2.1.0/BloodHound-linux-x64.zip
    unzip BloodHound-linux-x64.zip
    rm BloodHound-linux-x64.zip
    git clone https://github.com/fox-it/BloodHound.py.git
}

# Kekeo
installKekeo(){
	wget https://github.com/gentilkiwi/kekeo/releases/download/2.2.0-20190407/kekeo.zip
	unzip kekeo.zip
	mkdir kekeo
	mv x64 kekeoX64 && mv Win32 kekeoWin32 && mv samba kekeoSamba
	rm kekeo.zip
	mkdir kekeo; mv kekeo* ./kekeo; mv README.md ./kekeo
	rm kekeo.zip && rm README.md
}
# Kerbrute
installKerbrute(){
    wget https://github.com/ropnop/kerbrute/releases/download/v1.0.1/kerbrute_linux_amd64
    chmod 764 kerbrute_linux_amd64
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
