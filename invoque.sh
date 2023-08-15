#!/bin/bash

###############################################################################################
###############################################################################################

#Color Codes:

export PS3=$'\e[38;5;172m\ninvoque > \e[0m'
END="\e[0m"
GREEN="\e[1;92m"
RED="\e[1;91m"
CYAN="\033[36m"
MAGENTA="\033[35m"
YELLOW="\033[33m"
UNDERLINE="\033[4m"
today="$(date +%d-%m-%Y)"


###############################################################################################
###############################################################################################

quit()
{

cat << !

`printf "${CYAN}            +----------------------------------------+ ${END}"`
`printf "${CYAN}            |                                        | ${END}"`
`printf "${CYAN}            |      Thank you for using Invoque!      | ${END}"`
`printf "${CYAN}            |     vaibhav_masane A.K.A. @@DrGeek     | ${END}"`
`printf "${CYAN}            |                                        | ${END}"`
`printf "${CYAN}            +----------------------------------------+ ${END}"`

!
printf "${RED}Quitting the program ...${END}"
sleep 3
exit 0
}

###############################################################################################
###############################################################################################

# Define the folder name you're looking for

folder()

{

folder_name="invoque"

# Check if the folder exists
if [ ! -d "$folder_name" ]; then
  # Folder doesn't exist, create it
  mkdir "$folder_name"
fi

}

###############################################################################################
###############################################################################################

box_out() {
  local s=("$@") b w
  for l in "${s[@]}"; do
    ((w < ${#l})) && { b="$l"; w="${#l}"; }
  done
  tput setaf 6
  echo " -${b//?/-}-
| ${b//?/ } |"
  for l in "${s[@]}"; do
    # Replacing "\n" with newline character $'\n'
    l="${l//\\n/$'\n'}"
    printf '| %s%*s%s |\n' "$(tput setaf 7)" "-$w" "$l" "$(tput setaf 6)"
  done
  echo "| ${b//?/ } |
 -${b//?/-}-"
  tput sgr 0
}

###############################################################################################
###############################################################################################


invoque()
{

echo ""
printf "\n${CYAN}Select option: \n"
echo ""
invoque=("Invoke another command" "Quit Program")

select menu in "${invoque[@]}"; do

if [ "$menu" = "Invoke another command" ]; then
        bulk_invoquer
        elif [ "$menu" = "Quit Program" ]; then
        quit
        else
#if no valid option is chosen, chastise the user
        echo "That's not a valid option! Hit ENTER to show menu."
        fi
${END}
echo""
done

}

###############################################################################################
###############################################################################################

creds()

{

printf "\n${GREEN}Provide credentials: ${END}"

printf "\n${GREEN}Enter Username: ${END}"
read username

# Disable local echo
stty -echo
printf "${GREEN}Enter Password: ${END}"
read password
# Enable local echo again
stty echo

echo ""

}

###############################################################################################
###############################################################################################

bulk_invoquer()

{

# Read a comma-separated list of IP addresses from user input
printf "\n${CYAN}Enter a comma-separated list of ip_addresses/hostname: ${END}"
read address

# Read the command from user input
printf "\n${CYAN}Enter the command to execute on remote hosts: ${END}"
read remote_command

# Escape the single quotes in the remote command
escaped_remote_command="'$remote_command'"

echo ""

printf "${MAGENTA}Fetching output ...${END}"
sleep 3

echo ""

# Creating folder
folder

# Convert the comma-separated list into an array for IP/hosts
IFS=, read -ra address_array <<< "$address"

clock="$(date +%T | sed 's/:/_/g')"
outfile="./invoque/invoque-$today-$clock-$(date +%s).txt"

# Loop through each IP/hosts in the array and execute SSH command
for host in "${address_array[@]}"; do
    # Remove leading/trailing whitespace
    host=$(echo "$host" | xargs)

    echo ""

# Print the IP address

    echo "" >> "$outfile"

    printf "${YELLOW} > ${UNDERLINE}Host $host${END}${YELLOW}:\n${END}" >> "$outfile"

    echo "" >> "$outfile"

    # Construct and execute SSH command for each host
    sshpass -p "$password" ssh "$username"@"$host" bash -c "$escaped_remote_command" >> "$outfile"

echo -n "Check locally with the filename $outfile"

done

invoque

}

###############################################################################################
###############################################################################################
##WELCOME################
#########################
##START WELCOME MESSAGE##
###############################################################################################
###############################################################################################

cat << !

 █████                                                              
░░███                                                               
 ░███  ████████   █████ █████  ██████   ████████ █████ ████  ██████ 
 ░███ ░░███░░███ ░░███ ░░███  ███░░███ ███░░███ ░░███ ░███  ███░░███
 ░███  ░███ ░███  ░███  ░███ ░███ ░███░███ ░███  ░███ ░███ ░███████ 
 ░███  ░███ ░███  ░░███ ███  ░███ ░███░███ ░███  ░███ ░███ ░███░░░  
 █████ ████ █████  ░░█████   ░░██████ ░░███████  ░░████████░░██████ 
░░░░░ ░░░░ ░░░░░    ░░░░░     ░░░░░░   ░░░░░███   ░░░░░░░░  ░░░░░░  
                                           ░███                     
                                           █████                    
                                          ░░░░░                     

!


printf "            \e[0;30m\e[106m  Command Invoque. Author: @Vaibhav_Masane  \e[0m\n"

###############################################################################################
###############################################################################################

banner()
{
  echo "            +------------------------------------------+"
  printf "            |  %s  |\n" "`date`"
  echo "            +------------------------------------------+"
}
banner ""

###############################################################################################
###############################################################################################

###############################################################################################
###############################################################################################

# Instructions to use the script:
instructions=(

  "Instruction:"
  "   "
  "This script will help to invoke multiple commands on multiple devices."
  "   "
  "1. Make sure the credentials you are providing are present on all the" 
  "   devices on which you want to execute the command."
  "   "
  "2. You can use TACACS, RADIUS or AD credentials as well for access" 
  "   the devices if local login is not permitted."
  "   "
  "3. Provide exact and correct command to execute."
  "   "
  "4. If not sure the command provided is correct then first try the"
  "   command on a single device and then use this script."
  "   "
  "5. While using grep with command use \"-E\" flag to search multiple"
  "   words at a time like: grep -E \"word1|word2\""
  "   "
  "6. If for any reason you make a typo and need to exit use CTRL+C."
)

box_out "${instructions[@]}"

###############################################################################################
###############################################################################################

echo ""

printf "Press ENTER to continue..."
read ANYKEY

sleep 1

creds
bulk_invoquer
