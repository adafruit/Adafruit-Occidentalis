#!/usr/bin/env bash

cat << "EOF"
                                 .`
                              -dMMs
                             +MMMMMo
                           .dMMMMMMN-
                          +NMMMMMMMMd`
                        `hMMMMMMMMMMMo
                       -mMMMMMMMMMMMMN.
                       dMMMMMMMMMMMMMMo
  :hmmmmmmmmmmmmdhs/. `MMMMMMMMMMMMMMMh
  sMMMMMMMMMMMMMMMMMMd+NMMMMMMMMMMMMMM+
   /NMMMMMMMMMMMMMMMMMMMMMMMMs+NMMMMMm/+syyyso/-`
    `hMMMMMMMMMMMMMMMMMMMMMMo  hMMMMMMMMMMMMMMMMMNhs+:.
      /NMMMMMMMMMMMNmmNMMMMN. `mMMMMMMMMMMMMMMMMMMMMMMMNh-
       .hMMMMMMMMMMh` `-sNMMs-hMMMMMMMMMMMMMMMMMMMMMMMMMM+
         /mMMMMMMMMMNy+-./MMMMMMy:....oMMMMMMMMMMMMMMMNo.
           :ymMMMMMMMMMMMMMMMMMNy//oymMMMMMMMMMMMMMNy:
              .yMMMMMMMms:oMMNhNMMMMMMMMMMMMMMMMNh/`
            .yMMMMMMMN/  .dMMy `sMMMMMMMMMMMNmy/`
           /NMMMMMMMM:`-sMMMMM:  sMMMMMMs-..`
          -NMMMMMMMMMNNMMMMMMMMs./MMMMMMMh`
          mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs
         sMMMMMMMMMMMMMMMMhMMMMMMMMMMMMMMMN
        :MMMMMMMMMMMMMMMN+ hMMMMMMMMMMMMMMN.
       `dMMMMMMMMMMMMNh/`  `hMMMMMMMMMMMMMN.
       /MMMMMMMMmhs+-        /dMMMMMMMMMMMN.
       .hmdys/-                -sNMMMMMMMMN.
                                 `:hNMMMMMN.
                                    `+dMMMN`
                                       ./+-

  adding apt.adafruit.com to /etc/apt/sources.list

EOF

sleep 2

if grep -Fq "adafruit" /etc/apt/sources.list; then
  echo "adafruit repo already added to apt sources"
else
  # add apt repo to sources.list
  if grep -q "8.0" "/etc/debian_version"; then
    echo "deb http://apt.adafruit.com/raspbian/ jessie main" >> /etc/apt/sources.list
  else
    echo "deb http://apt.adafruit.com/raspbian/ wheezy main" >> /etc/apt/sources.list
  fi

  # import repo key
  wget -O - -q https://apt.adafruit.com/apt.adafruit.com.gpg.key | apt-key add -
fi

# pin apt.adafruit.com origin for anything installed there:
if [ ! -f /etc/apt/preferences.d/adafruit ]; then
  echo "pinning apt.adafruit.com origin" 
  echo "edit /etc/apt/preferences.d/adafruit to change"
  echo -e "Package: *\nPin: origin \"apt.adafruit.com\"\nPin-Priority: 1001" > /etc/apt/preferences.d/adafruit
else
  echo "/etc/apt/preferences.d/adafruit already exists - leaving alone"
fi

# update package database
apt-get update
