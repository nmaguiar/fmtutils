#!/bin/sh

# Execute /usr/bin/usage-help if no argument is provided otherwise execute the provided command
if [ $# -eq 0 ]; then
  /usr/bin/usage-help
else
  # if doesn't include sudo include sudo
  #if [ "$1" != "sudo" ]; then
  #  set -- sudo -E "$@"
  #fi
  exec "$@"
fi