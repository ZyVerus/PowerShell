#-----------------------------------------------#
#                                               #
#   Name: Clear All User Profile Browser Data   #
#   Created By: ZyVerus                         #
#   Latest Revision Date: 2018 June 14          #
#   Version: 1.1                                #
#                                               #
#   This script pulls a list of computers       #
#   from a csv file, and deletes the browser    #
#   data for the four main browsing providers   #
#   as well as Flash Player data                #
#                                               #
#   Update: Added the fix for Firefox           #
#   to recreate the profile after being         #
#   deleted.                                    #
#                                               #
#-----------------------------------------------#

#Change the location of the CSV File that contains the list of all the systems included below
$TribalCSV = Import-Csv C:\Users\zyverus\Desktop\TribalFusionAffectedWorkstationsGCE5.csv | ForEach-Object {

    $Systemname = $_.SystemName

    Invoke-Command -ComputerName $Systemname {

    $UserDirectory = dir "C:\Users" | ?{$_.PSISContainer}
    
    #$d Variable represents each user profile stored on the computer.
    Foreach ($d in $UserDirectory){
        
        #Internet Explorer cookies storage location
        $IECookies = "C:\Users\$d\AppData\Roaming\Microsoft\Windows\Cookies"

        #Google Chrome stores cookies in an SQLite Library
        $ChromeUserData = "C:\Users\$d\AppData\Local\Google\Chrome\User Data"

        #Firefox stores cookies in an SQLite Library
        $FireFoxProfileFolder = "C:\Users\$d\AppData\Local\Mozilla\Firefox\Profiles"
        $FireFoxProfileFolder2 = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\Profiles"
        $FireFoxDefProfileFolder = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\Profiles\firefox.default"
        $FireFoxProfilesINI = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\profiles.ini"

        #It is believed the Spyware was introduced  through an Adobe Flash Ad, so the Flash Data will be cleared for safety measures.
        $FlashSharedObjects1 = "C:\Users\$d\AppData\Roaming\Macromedia\Flash Player\#SharedObjects"
        $FlashSharedObjects2 = "C:\Users\$d\AppData\Roaming\Macromedia\Flash Player\macromedia.com\support\flashplayer\sys"

        #Kill the Internet Explorer process, and delete the associated browser cookies for each user profile.
        $iexplorer = Get-Process -Name iexplore
        Stop-Process $iexplorer -Force
        del $IECookies -Recurse -Force

        #Kill the Google Chrome process, and delete the associated browser data and caches (including Cookies) for each user profile.
        $chrome = Get-Process -Name Chrome
        Stop-Process -InputObject $chrome -Force
        del $ChromeUserData -Recurse -Force

        #Kill the Firefox process, and delete the associated browser data and caches (including Cookies) for each user profile.
        $firefox = Get-Process -Name firefox
        Stop-Process -InputObject $firefox -Force
        del $FireFoxProfileFolder -Recurse -Force
        del $FireFoxProfileFolder2 -Recurse -Force
        mkdir $FireFoxProfileFolder -Force
        mkdir $FireFoxProfileFolder2 -Force
        mkdir $FireFoxDefProfileFolder -Force

        Set-Content -Value ("
[General]
StartWithLastProfile=1

[Profile0]
Name=default
IsRelative=1
Path=Profiles/firefox.default
Default=1
                            ") -Path $FireFoxProfilesINI

        #Kill the Macromedia Flash process, and delete the data for each user profile.
        $Flash = Get-Process FlashUtil_ActiveX
        Stop-Process -InputObject $Flash -Force
        del $FlashSharedObjects1 -Recurse -Force
        del $FlashSharedObjects2 -Recurse -Force

        }
    }
}