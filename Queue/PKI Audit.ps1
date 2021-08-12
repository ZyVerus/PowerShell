function Get-NestedGroupMember {
    [CmdLetBinding()]
    param
    (
    [Parameter(Mandatory)]
    [string]$Group
    )

    #Find all members in the group specified
    $members = Get-ADGroupMember -Identity $Group
    foreach ($member in $members)
    {

    #If any member in that group is another group just call this function again
    if ($member.objectClass -eq 'group')
    {
    Get-NestedGroupMember -Group $member.Name
    }

    if ($member.objectClass -eq 'user')
    {
    Get-ADUser -Identity $member.samAccountName -Properties *
    }

    else #Otherwise, just output the non-group object (User accounts)
    {
    $member.Name
    }
    }
    }

$DomainAdmins = Get-ADGroup -Identity 'Domain Admins' | Select-Object -ExpandProperty DistinguishedName
$ServerAdmins = Get-ADGroup -Identity 'Server Admins' | Select-Object -ExpandProperty DistinguishedName
$CNDAdmins = Get-ADGroup -Identity 'CND Admins' | Select-Object -ExpandProperty DistinguishedName
$UnitAdmins = Get-ADGroup -Identity 'Unit Admins All' | Select-Object -ExpandProperty DistinguishedName
$ServiceDesk = Get-ADGroup -Identity 'Service Desk All' | Select-Object -ExpandProperty DistinguishedName
$DomainUsers = Get-ADGroup -Identity 'Domain Users' | Select-Object -ExpandProperty DistinguishedName

#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $DomainAdmins} | ogv
#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $ServerAdmins} | ogv
#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $CNDAdmins} | ogv
#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $UnitAdmins} | ogv
#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $ServiceDesk} | ogv
#Get-ADUser -Filter {SmartCardLogonRequired -eq $False -and Memberof -eq $DomainUsers} | ogv

$DomainAdminsMembers = Get-NestedGroupMember -Group $DomainAdmins | where {$_.ObjectClass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "Domain Admins: $(($DomainAdminsMembers.samaccountname | select -Unique).count)"
$DomainAdminsMembersExempt = Get-NestedGroupMember -Group $DomainAdmins | where {$_.ObjectClass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "Domain Admins Exempt: $(($DomainAdminsMembersExempt.samaccountname | select -Unique).count)"
Echo "Domain Admins Exempted:"
Get-NestedGroupMember -Group $DomainAdmins | where {$_.ObjectClass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName

$ServerAdminsMembers = Get-NestedGroupMember -Group $ServerAdmins | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "Server Admins: $(($ServerAdminsMembers.samaccountname | select -Unique).count)"
$ServerAdminsMembersExempt = Get-NestedGroupMember -Group $ServerAdmins | where {$_.ObjectClass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "Server Admins Exempt: $(($ServerAdminsMembersExempt.samaccountname | select -Unique).count)"
Echo "Server Admins Exempted:"
Get-NestedGroupMember -Group $ServerAdmins | where {$_.ObjectClass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName

$CNDAdminsMembers = Get-NestedGroupMember -Group $CNDAdmins | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "CND Admins: $(($CNDAdminsMembers.samaccountname | select -Unique).count)"
$CNDAdminsMembersExempt = Get-NestedGroupMember -Group $CNDAdmins | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "CND Admins Exempt: $(($CNDAdminsMembersExempt.samaccountname | select -Unique).count)"
Echo "CND Admins Exempted:"
Get-NestedGroupMember -Group $CNDAdmins | where {$_.objectclass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName

$UnitAdminsMembers = Get-NestedGroupMember -Group $UnitAdmins | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "Unit Admins: $(($UnitAdminsMembers.samaccountname | select -Unique).count)"
$UnitAdminsMembersExempt = Get-NestedGroupMember -Group $UnitAdmins | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "Unit Admins Exempt: $(($UnitAdminsMembersExempt.samaccountname | select -Unique).count)"
Echo "Unit Admins Exempted:"
Get-NestedGroupMember -Group $UnitAdmins | where {$_.objectclass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName

$ServiceDeskMembers = Get-NestedGroupMember -Group $ServiceDesk | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "Service Desk Members: $(($ServiceDeskMembers.samaccountname | select -Unique).count)"
$ServiceDeskMembersExempt = Get-NestedGroupMember -Group $ServiceDesk |  where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "Service Desk Members Exempt: $(($ServiceDeskMembersExempt.samaccountname | select -Unique).count)"
Echo "Service Desk Members Exempted:"
Get-NestedGroupMember -Group $ServiceDesk |  where {$_.objectclass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName

#$DomainUsersMembers = Get-NestedGroupMember -Group $DomainUsers | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'}
#Write-Output "Domain Users: $(($DomainUsersMembers.samaccountname | select -Unique).count)"
#$DomainUsersMembersExempt = Get-NestedGroupMember -Group $DomainUsers | where {$_.objectclass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
#Write-Output "Domain Users Exempt: $(($DomainUsersMembersExempt.samaccountname | select -Unique).count)"
#Echo "Domain Users Exempted:"
#Get-NestedGroupMember -Group $DomainUsers |  where {$_.objectclass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | fl DisplayName,SamAccountName