#!/bin/zsh

########################################################################
#            Grant Temporary Admin Privileges - postinstall            #
####################### written by Phil Walker #########################
########################################################################

########################################################################
#                            Variables                                 #
########################################################################

# Deferral Options
deferralOption1="600"
deferralOption2="3600"
deferralOption3="10800"
deferralOption4="28800"
# Get the logged in user
loggedInUser=$(stat -f %Su /dev/console)
# Get the hostname
hostName=$(scutil --get HostName)
# Launch Daemon
launchDaemon="/Library/LaunchDaemons/com.bauer.tempadmin.plist"
# Jamf Helper
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
# Helper icon
helperIcon="/Library/Application Support/JAMF/bin/Management Action.app/Contents/Resources/Self Service.icns"
# Helper title
helperTitle="Message from Bauer IT"
# Log file
logFile="/Library/Logs/Bauer/TempAdmin/TempAdmin.log"
# Date and time
datetime=$(date +%d-%m-%Y\ %T)

########################################################################
#                            Functions                                 #
########################################################################

function getRealName ()
{
# Find correct format for real name of logged in user
loggedInUserUID=$(dscl . -read /Users/"$loggedInUser" UniqueID | awk '{print $2}')
if [[ "$loggedInUser" =~ "admin" ]];then
    userRealName=$(dscl . -read /Users/"$loggedInUser" | grep -A1 "RealName:" | sed -n '2p' | awk '{print $1, $2, $3}' | sed s/,//)
else
    if [[ "$loggedInUserUID" -lt "1000" ]]; then
        userRealName=$(dscl . -read /Users/"$loggedInUser" | grep -A1 "RealName:" | sed -n '2p' | awk '{print $1, $2}' | sed s/,//)
    else
        userRealName=$(dscl . -read /Users/"$loggedInUser" | grep -A1 "RealName:" | sed -n '2p' | awk '{print $2, $1}' | sed s/,//)
    fi
fi

}

function jamfHelperAdminPeriod ()
# Prompt the user to select the time period they which to have admin rights for
{
HELPER=$(
"$jamfHelper" -windowType utility -icon /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UserIcon.icns -title "$helperTitle" \
-heading "Admin Privileges Requested" -alignHeading left -description "Please select the time period you require admin privileges for

" -lockHUD -showDelayOptions "$deferralOption1, $deferralOption2, $deferralOption3, $deferralOption4"  -button1 "Select"

)
}

function convertTimePeriod ()
{
# Convert the seconds chosen to human readable minutes, hours. No Seconds are calulated
local T=$timeChosen;
local H=$((T/60/60%24));
local M=$((T/60%60));
timeChosenHuman=$(printf '%s';[[ $H -eq 1 ]] && printf '%d hour' $H; [[ $H -ge 2 ]] && printf '%d hours' $H; [[ $M -gt 0 ]] && printf '%d minutes' $M; [[ $H -gt 0 || $M -gt 0 ]])
}

function helperAdminGranted ()
{
# Show jamfHelper message to advise admin rights given and how long the privileges will be in place for
"$jamfHelper" -windowType utility -icon "$helperIcon" -title "Message from Bauer IT" -heading "🔓 Administrator Privileges Granted" \
-description "$userRealName now has admin rights on $hostName for $timeChosenHuman

After $timeChosenHuman, admin privileges will be automatically removed.

During the $timeChosenHuman of elevated privileges please remember....

    #1) All activity on your Bauer Media owned Mac is monitored.
    #2) Think before you approve installs or updates
    #3) With great power comes great responsibility." -button1 "Ok" -defaultButton 1
}

function helperAdminFailed ()
{
# Show jamfHelper message to advise the process failed
"$jamfHelper" -windowType utility -icon "$helperIcon" -title "Message from Bauer IT" -heading "Administrator Priviliges failed" \
-description "It looks like something went wrong when trying to change your account priviliges.

Please contact the IT Service Desk for assistance" -button1 "Ok" -defaultButton 1
}

########################################################################
#                         Script starts here                           #
########################################################################

# Create the log directory if required
if [[ ! -d "/Library/Logs/Bauer/TempAdmin" ]]; then
    mkdir -p "/Library/Logs/Bauer/TempAdmin"
fi
# Create the log file if required
if [[ ! -e "$logFile" ]]; then
    touch "$logFile"
fi
# Get the users real name for helper windows
getRealName
# Provide time period options
jamfHelperAdminPeriod
# Removes the 1 added to the time period chosen
timeChosen="${HELPER%?}"
# Convrt the time period chosen for the helper window
convertTimePeriod
# Promote the logged in user to an admin
dseditgroup -o edit -a "$loggedInUser" -t user admin
# Add time period to LaunchDaemon
/usr/libexec/PlistBuddy -c "Set StartInterval $timeChosen" "$launchDaemon"
# Boostrap the Launch Daemon to remove admin rights after the chosen period has elapsed
launchctl bootstrap system "$launchDaemon"
if [[ $(launchctl list | grep "com.bauer.tempadmin") != "" ]]; then
    echo "Temp Admin Launch Daemon now bootstrapped"
else
    echo "Attempting to boostrap the Launch Daemon again..."
    launchctl bootstrap system "$launchDaemon"
    if [[ $(launchctl list | grep "com.bauer.tempadmin") != "" ]]; then
        echo "Temp Admin Launch Daemon now bootstrapped"
    else
        echo "Failed to boostrap the Launch Daemon"
        echo "It should be boostrapped on the next boot"
    fi
fi
# Get a list of users who are in the admin group
adminUsers=$(dscl . -read Groups/admin GroupMembership | cut -c 18-)
# Check if the logged in user is in the admin group and show jamfHelper message
if [[ "$adminUsers" =~ $loggedInUser ]]; then
    echo "${datetime}: $loggedInUser has been granted admin rights for $timeChosenHuman" >> "$logFile"
    # Kill bitbar to read new user rights when holding alt key
    killall BitBarDistro
    # Show jamfHelper message to advise admin rights given and how long the privileges will be in place for
    helperAdminGranted
    exit 0
else
    echo "Something went wrong - $loggedInUser is not an admin"
    helperAdminFailed
    exit 1
fi