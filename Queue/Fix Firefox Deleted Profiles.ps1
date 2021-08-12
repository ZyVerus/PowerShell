#-----------------------------------------------#
#                                               #
#   Name: Fix Firefox Deleted Profiles          #
#   Created By: ZyVerus                         #
#   Latest Revision Date: 2018 June 14          #
#                                               #
#   This script recreates the Firefox profile   #
#   after being deleted.                        #
#                                               #
#   The .ps1 file "Clear All user Profile       #
#   Browser Data.ps1" utilizes this script      #
#   file.                                       #
#                                               #
#-----------------------------------------------#

#Change the location of the CSV File that contains the list of all the systems included below
$TribalCSV = Import-Csv C:\Users\zyverus\Desktop\TribalFusionAffectedWorkstations.csv | ForEach-Object {

    $Systemname = $_.SystemName

    Invoke-Command -ComputerName $Systemname {

    $UserDirectory = dir "C:\Users" | ?{$_.PSISContainer}
    
    #$d Variable represents each user profile stored on the computer.
    Foreach ($d in $UserDirectory){

        #Firefox stores cookies in an SQLite Library
        $FireFoxProfileFolder = "C:\Users\$d\AppData\Local\Mozilla\Firefox\Profiles"
        $FireFoxProfileFolder2 = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\Profiles"
        $FireFoxDefProfileFolder = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\Profiles\firefox.default"
        $FireFoxProfilesINI = "C:\Users\$d\AppData\Roaming\Mozilla\Firefox\profiles.ini"

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

        }
    }
}