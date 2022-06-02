#!/bin/bash
set -e

echo "(('export PEAT_DESK_PATH=your/path/here' to avoid this prompt))"

if [[ ${PEAT_DESK_PATH} && ${PEAT_DESK_PATH-x} ]]; then
  DESK_PATH=$PEAT_DESK_PATH
else
  while true; do    # TODO
    printf "\nEnter the path to your desk (like ~/urbit/peat-zod/peat): "
    read USER_PATH
    printf "\nYou entered: $USER_PATH. Okay? (y/n)"
    read -n 1 decision
    case $decision in
      [yY])
        printf "\nOkay."
        break
      ;; # contiue
      [nN]) # try again
    esac
  done
  DESK_PATH=$USER_PATH
fi

watch cp -RL ./urbit/* $DESK_PATH
