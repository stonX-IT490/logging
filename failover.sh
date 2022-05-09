#!/bin/bash
primary="10.4.90.52"
secondary="10.4.90.62"

if ping -c 1 -W 1 $primary; then
  echo $primary
  sed -i "s/$secondary/$primary/" /etc/hosts
else
  echo $secondary
  sed -i "s/$primary/$secondary/" /etc/hosts
fi
