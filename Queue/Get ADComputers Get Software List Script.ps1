#--------------------------------------------------#
#                                                  #
#                                                  #
#  Name: Get ADComputer Get Software List Script   #
#  Created By: Hugo M. Baez Urquiola               #
#  Latest Revision: 2018 July 3                    #
#  Version: 1.3                                    #
#                                                  #
#  This script gets all AD computers with the      #
#  number '7' in the name and gets the software    #
#  installed on the machines, exports it to a CSV  #
#  file, and copies the data to the machine        #
#  running this script                             #
#                                                  #
#                                                  #
#--------------------------------------------------#

$ExportDirectory = mkdir "C:\Software Reports"
$ADComputerList = Get-ADComputer -Filter "Name -like '*7*'" -Properties * | Select -ExpandProperty Name

Foreach ($SystemName in $ADComputerList){

    Invoke-Command -ComputerName $SystemName {
        $comphostname = hostname
        $Date = (get-date -f yyyy-MM-dd)
        $A=mkdir C:\SoftwareReportsScript\Win32Reg_AddRemovePrograms
        $B=mkdir C:\SoftwareReportsScript\Win32_InstalledWin32Program
        $A.Attributes="hidden"
        $B.Attributes="hidden"

            Get-WmiObject -Class Win32Reg_AddRemovePrograms | Export-Csv "C:\SoftwareReportsScript\Win32Reg_AddRemovePrograms\$comphostname $Date A.csv"
            Get-WmiObject -Class Win32_InstalledWin32Program | Export-Csv "C:\SoftwareReportsScript\Win32_InstalledWin32Program\$comphostname $Date B.csv"
        }

    $origin = "\\$SystemName\C$\SoftwareReportsScript"
    $destination = "C:\Software Reports"
    #$f = (get-item $destination -Force)
    #$f.Attributes = "Directory"

    robocopy $origin $destination /R:0 /S
    Get-Item $destination -Force | Foreach {$_.Attributes = "Directory"}
    Get-ChildItem -Path $destination -Recurse -Force | foreach {$_.Attributes = "Archive"}
    del $origin -Recurse -Force
    }

#Win32Reg_AddRemovePrograms, Win32_InstalledWin32Program, CAUTION: Win32Product#