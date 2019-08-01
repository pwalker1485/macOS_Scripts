#!/bin/bash

########################################################################
#                      FileVault Deferral Status                       #
################## written by Phil Walker July 2019 ####################
########################################################################

FV2Deferred=$(fdesetup status | sed -n 2p)

if [[ "$FV2Deferred" == "" ]] || [[ "$FV2Deferred" =~ "Encryption in progress" ]]; then
  echo "<result>Not deferred</result>"
else
  FV2DeferralUser=$(fdesetup status | sed -n 2p | awk '{print $9}' | cut -d "'" -f2)
  echo "<result>FileVault deferred for: ${FV2DeferralUser}</result>"
fi

exit 0