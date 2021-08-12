$date = Get-Date

$das = Get-ADGroupMember "Domain Admins" | where {$_.samaccountname -notlike "*svc*"}
$daspki = foreach ($da in $das){Get-ADUser $da -Properties SmartCardLogonRequired | where {$_.smartcardlogonrequired -eq $False}}
$daspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedDAs.csv 
write-host "There are" $das.count "Domain Admins"
write-host "There are" $daspki.count "unenforced Domain Admins"
write-host (100-((($daspki.count)/($das.count))*100))"% enforced"

$sas = Get-ADGroupMember "Server Admins"| where {$_.samaccountname -notlike "*svc*"}
$saspki = foreach ($sa in $sas){Get-ADUser $sa -Properties SmartCardLogonRequired | where {$_.smartcardlogonrequired -eq $False}}
$saspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedSAs.csv 
write-host "There are" $sas.count "Server Admins"
write-host "There are" $saspki.count "unenforced Server Admins"
write-host (100-((($saspki.count)/($sas.count))*100))"% enforced"

$uas = Get-ADGroupMember "Unit Admins All" -Recursive | where {$_.objectclass -eq "User"}
$uaspki = foreach ($ua in $uas){Get-ADUser $ua -Properties SmartCardLogonRequired | where {$_.smartcardlogonrequired -eq $False}}
$uaspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedUAs.csv 
write-host "There are" $uas.count "Unit Admins"
write-host "There are" $uaspki.count "unenforced Unit Admins"
write-host (100-((($uaspki.count)/($uas.count))*100))"% enforced"

$cnds = Get-ADGroupMember "CND Admins"| where {$_.samaccountname -notlike "*svc*"}
$cndspki = foreach ($cnd in $cnds){Get-ADUser $cnd -Properties SmartCardLogonRequired | where {$_.smartcardlogonrequired -eq $False}}
$cndspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedCNDs.csv 
write-host "There are" $cnds.count "CND Admins"
write-host "There are" $cndspki.count "unenforced CND Admins"
write-host (100-((($cndspki.count)/($cnds.count))*100))"% enforced"

$sds = Get-ADGroupMember "Service Desk All" -Recursive | where {$_.objectclass -eq "User"}
$sdspki = foreach ($sd in $sds){Get-ADUser $sd -Properties SmartCardLogonRequired | where {$_.smartcardlogonrequired -eq $False}}
$sdspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedSDs.csv 
write-host "There are" $sds.count "Service Desk Admins"
write-host "There are" $sdspki.count "unenforced Service Desk Admins"
write-host (100-((($sdspki.count)/($sds.count))*100))"% enforced"

$users = get-aduser -filter {userprincipalname -notlike "*.svc*"} -SearchBase "OU=ME User Catalog,DC=ME,DC=USMC,DC=MIL" -Properties SmartCardLogonRequired
$userspki = $users | where {($_.smartcardlogonrequired -eq $False) -and ($_.userprincipalname -notlike "*.svc*")}
$userspki | select name,userprincipalname,distinguishedname,smartcardlogonrequired,enabled | export-csv unenforcedUsers.csv 
write-host "There are" $users.count "Domain Users"
write-host "There are" $userspki.count "unenforced Domain Users"
write-host (100-((($userspki.count)/($users.count))*100))"% enforced"

$515users = get-aduser -filter {userprincipalname -notlike "*.svc*"} -SearchBase "OU=515,OU=ME User Catalog,DC=ME,DC=USMC,DC=MIL" -Properties SmartCardLogonRequired
$515userspki = $515users | where {($_.smartcardlogonrequired -eq $False) -and ($_.userprincipalname -notlike "*.svc*")}
write-host "There are" $515users.count "515 Users"
write-host "There are" $515userspki.count "unenforced 515 Users"
write-host (100-((($515userspki.count)/($515users.count))*100))"% enforced"

$mhnusers = get-aduser -filter {userprincipalname -notlike "*.svc*"} -SearchBase "OU=MHN,OU=ME User Catalog,DC=ME,DC=USMC,DC=MIL" -Properties SmartCardLogonRequired
$mhnuserspki = $mhnusers | where {($_.smartcardlogonrequired -eq $False) -and ($_.userprincipalname -notlike "*.svc*")}
write-host "There are" $mhnusers.count "MHN Users"
write-host "There are" $mhnuserspki.count "unenforced MHN Users"
write-host (100-((($mhnuserspki.count)/($mhnusers.count))*100))"% enforced"

$spmagtfusers = get-aduser -filter {userprincipalname -notlike "*.svc*"} -SearchBase "OU=SPMAGTF,OU=ME User Catalog,DC=ME,DC=USMC,DC=MIL" -Properties SmartCardLogonRequired
$spmagtfuserspki = $spmagtfusers | where {($_.smartcardlogonrequired -eq $False) -and ($_.userprincipalname -notlike "*.svc*")}
write-host "There are" $spmagtfusers.count "SPMAGTF Users"
write-host "There are" $spmagtfuserspki.count "unenforced SPMAGTF Users"
write-host (100-((($spmagtfuserspki.count)/($spmagtfusers.count))*100))"% enforced"
