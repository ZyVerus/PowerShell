#--------------------------------------------------#
#                                                  #
#  Name: Query AD Computer for File Keywords       #
#  Created By: ZyVerus               #
#  Latest Revision: 2019 Feb 13                    #
#  Version: 1.0                                    #
#                                                  #
#  This powershell script searches all AD          #
#  computers for a specified file if the machine   #
#  is online.                                      #
#                                                  #
#--------------------------------------------------#

#Specify the Directory to output Result Files to
$ExportDirectory = "C:\Jupiter Sweep Query Reports"

#Get a List of Active Directory Computers
$ADComputerList = Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=515,OU=ME User Catalog,DC=ME,DC=USMC,DC=MIL" -Properties * | Select -ExpandProperty Name
#$ADComputerList = Get-ADComputer -Filter "Name -like '*ME-SPM-N-CDKT*'" -Properties * | Select -ExpandProperty Name

ForEach ($SystemName in $ADComputerList){
    #Test the connection to the Machine. If the Machine is online, execute the script. Otherwise, skip to the next machine.
    if (Test-Connection $SystemName -BufferSize 8 -Count 2 -Quiet) {

        invoke-command -ComputerName $SystemName {
           #Create variables to use for the result file's naming standard
           $comphostname = hostname
           #$Date = (get-date -f yyyy-MM-dd)

           #Enter Filepath to Search
           $FilePath = "C:\Users\"

           #Include each Filename to search for.
           #Ensure to include wildcards * to expand the search parameters to not be limited by exact file names.
           $FileNames = @(
                "*Filename.pdf*"
                #"*Filename_2*"
                #"*Filename_3*"
                )

           #Create a hidden directory on the target machine to output the results file to.
           $ReportDir=mkdir 'C:\FileQuery\'
           $ReportDirAttributes="hidden"
           $ResultsFile = "C:\FileQuery\$comphostname Query Results.csv"

           #Search for Files that match the names included in the $FileNames list. The output will be the full file path in a .csv.
           Get-ChildItem -Path $FilePath -Include $Filenames -File -Recurse -Force -ErrorAction SilentlyContinue | Select-Object FullName | Out-File $ResultsFile
           }

           #| %{Write-Progress -Activity " $comphostname - Found File: $_.FullName; $_" }

        #Specify the location of the results file, and the destination that it will be copied to.
        #The $Destination variable pulls from the $ExportDirectory variable previously defined in this script.
        #The logic behind creating a variable to call a previous variable is simply to maintain naming consistency with related variables.

        $Origin = "\\$SystemName\C$\FileQuery"
        $Destination = $ExportDirectory

        #Check if the Results File has any content in it. If it has content, then copy the file to the C Drive of the machine this script is being executed from
        if ((Get-Item "$Origin\$SystemName Query Results.csv").length -gt 0kb){
            robocopy $origin $destination /R:0 /S
            Get-Item $destination -Force | Foreach {$_.Attributes = "Directory"}
            Get-ChildItem -Path $destination -Recurse -Force | foreach {$_.Attributes = "Archive"}
            del $origin -Recurse -Force
            Add-Content "$ExportDirectory\Systems Containing File.csv" -Value $SystemName
            } else {
            del $origin -Recurse -Force
            Add-Content "$ExportDirectory\Systems Without File.csv" -Value $SystemName
        }
    } 

    #If Unable to Ping machine, add to the List of Systems that could not be scanned.
    else {
    Add-Content "$ExportDirectory\Systems Not Scanned.csv" -Value $SystemName
    }
}