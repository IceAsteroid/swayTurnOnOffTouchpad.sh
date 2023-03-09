#!/bin/bash

sh_dir=$(dirname "$0")
source ${sh_dir}/funcLib.sh

notAsRoot_

confDir="${HOME}/.config/swayTurnOnOffTouchpad"
confFile="${confDir}/touchpadID.txt"
touchpadOnOrOffConfFile="/tmp/swayTouchpadOnOrOff.txt"

[ -d ${confDir} ] || mkdir -p ${confDir}

printUsage_() {
  local count=${#}
  #if the option isn't -o -f -c, or existnt, print the help page.
  if [[ ! "${1}" =~ ^-[tc]$ ]]; then
    cat <<EOF
$(echoGreen_ "## Help Page ##")
$(echoGreen_ "Usage:")
  $(echo $(basename "$0")) [OPTION]
  -t Turn on or off events of selected touchpad device 
  -c Configure which input device as touchpad
  -h Print help page
EOF
    exit
  fi
}
printUsage_ ${@}

selectInputDeviceAsTouchpad_() {
  declare -a inputInfos
  declare count chosenOrdinalOfInputDevice touchpadsID
IFS=''
  # store swaymsg's output separated by blank lines into an array
  readarray -d '' inputInfos < <(awk -v RS= -v ORS='\0' '1' <(swaymsg --pretty --type get_inputs))
  while true; do
    echoGreen_ "# List of Input Devices:"
    count=0
    for inputInfo in ${inputInfos[@]}; do
      cat <<EOF
#${count} ${inputInfo}

EOF
      ((count+=1))
    done
    echoGreen_ "# Choose input device as touchpad by ordinal"
    while read -p "#(PROMPT)Enter number: " chosenOrdinalOfInputDevice; do
      [[ "${chosenOrdinalOfInputDevice}" =~ ^[0-9]+$ ]] && { echo; break; } || echoRed_ "#!Please, Re-enter!"
    done
    touchpadsID="$(grep -E '.*Identifier: .+' <<<${inputInfos[${chosenOrdinalOfInputDevice}]} | awk -F' ' '{print $NF}')"
    echoGreen_ "# Chosen input devive:"
    cat <<EOF
#${chosenOrdinalOfInputDevice} ${inputInfos[${chosenOrdinalOfInputDevice}]}
$(echoGreen_ "#Selected ID: ${touchpadsID}")
EOF
    read -n1 -p "#(PROMPT)Corrent(Y/n)? "; echo; echo
    case ${REPLY} in
      Y|y) break;;
      *) sleep 0;;
    esac
  done
unset IFS
  echoGreen_ "# Writing ID to the conf file.."
  echo ${touchpadsID} > ${confFile} && echo "# Writing success" || echoRed_ "#!Writing Failed!"
}

autoCnfgrTouchpadOnOrOffConfIfNonexstntOrEmpty_() {
  # touchpad's turned on in ${touchpadOnOrOffConfFile} conf by default when this script runs after bootup
  [ -s ${touchpadOnOrOffConfFile} ] || \
    cat <<EOF > ${touchpadOnOrOffConfFile}
touchpad status: on
EOF
}

#turnOnOrOffTouchpad_() {
#  declare touchpadIDFromConf
#  touchpadIDFromConf="$(cat ${confFile})"
#  if [ "${1}" == -o ]; then
#    swaymsg "input ${touchpadIDFromConf} events enabled" && echo "# Enabling touchpad success" || { echo "#!Enabling Touchpad Failed!"; exit 2; }
#  elif [ "${1}" == -f ]; then
#    swaymsg "input ${touchpadIDFromConf} events disabled" && echo "# Disabling touchpad success" || { echo "#!Disabling Touchpad Failed!"; exit 2; }
#  fi
#}

VTouchpadStatus_() {
  declare touchpadStatus
  touchpadStatus="$(grep '^touchpad status: .*' ${touchpadOnOrOffConfFile} | awk -F' ' '{print $NF}')"
  echo ${touchpadStatus}
}

turnOnOrOffTouchpad_() {
  declare touchpadIDFromConf touchpadStatus
  touchpadIDFromConf="$(cat ${confFile})"
  touchpadStatus="$(VTouchpadStatus_)"
  if [ "${touchpadStatus}" == on ]; then
    swaymsg "input ${touchpadIDFromConf} events disabled" && echo "# Disabling touchpad success" || { echo "#!Disabling Touchpad Failed!"; exit 2; }
    cat <<EOF > ${touchpadOnOrOffConfFile}
touchpad status: off
EOF
  elif [ "${touchpadStatus}" == off ]; then
    swaymsg "input ${touchpadIDFromConf} events enabled" && echo "# Enabling touchpad success" || { echo "#!Enabling Touchpad Failed!"; exit 2; }
    cat <<EOF > ${touchpadOnOrOffConfFile}
touchpad status: on
EOF
  fi
}

[ "${1}" == -c ] && selectInputDeviceAsTouchpad_
#[[ "${1}" =~ ^-[of]$ ]] && turnOnOrOffTouchpad_ ${1}
[ "${1}" == -t ] && { autoCnfgrTouchpadOnOrOffConfIfNonexstntOrEmpty_; turnOnOrOffTouchpad_; }






