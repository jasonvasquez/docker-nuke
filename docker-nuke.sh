#!/bin/bash

readonly countdown_time=5

readonly bold=$(tput bold)
readonly normal=$(tput sgr0)

announce() {
  if hash say 2>/dev/null; then
    say "$@"
  fi
}

countdown() {
  local readonly seconds=$1

  announce "T minus "
  for i in $(seq $seconds 1); do
    echo "${i}..."
    announce $i
    sleep 1
  done
}

running_containers() {
  docker ps -q
}

all_containers() {
  docker ps -aq
}

images() {
  docker images -aq
}

volumes() {
  docker volume ls -q
}

is_function() {
  type $1 2>/dev/null | grep -q 'function'
}

count() {
  is_function "$1" &&   eval $1 | wc -l | tr -d ' '   || {
    echo "$1 is not an internal function that can be counted"
    exit 1
  }
}

at_least_something_exists() {
  (( $(count all_containers) > 0 )) || \
  (( $(count images) > 0 )) || \
  (( $(count volumes) > 0 ))
}




echo ""
echo ""

[[ $0 == *".sh" ]] || {
  echo "    ${bold}Looks like you may be running this via curl...${normal}"
  echo "    Feel free to audit this script at https://github.com/jasonvasquez/docker-nuke"
  echo ""
  sleep 3
}


at_least_something_exists || {
  echo "    Nothing to nuke!"
  echo ""
  exit 0
}

echo "    About to nuke your docker world..."
echo "    All containers, images and volumes will be deleted permanently."
echo ""
echo "    Current Inventory:"
echo "        Running containers to be killed: $(count running_containers)"
echo "        Total containers to be deleted: $(count all_containers)"
echo ""
echo "        Total images to be deleted: $(count images)"
echo ""
echo "        Total volumes to be deleted: $(count volumes)"
echo ""
echo "    ${bold}You have ${countdown_time} seconds to ^c-nope your way out of this.${normal}"
echo ""

sleep 1
countdown ${countdown_time}

echo boom.

echo ""

(( $(count running_containers) == 0 )) || {
  echo "Killing running containers..."
  docker kill $(running_containers) 2>/dev/null
}

(( $(count all_containers) == 0 )) || {
  echo "Deleting containers..."
  docker rm $(all_containers) 2>/dev/null
}

(( $(count images) == 0 )) || {
  echo "Deleting images..."
  docker rmi -f $(images) 2>/dev/null
}

(( $(count volumes) == 0 )) || {
  echo "Deleting volumes..."
  docker volume rm $(volumes) 2>/dev/null
}

echo ""
echo "done!"
