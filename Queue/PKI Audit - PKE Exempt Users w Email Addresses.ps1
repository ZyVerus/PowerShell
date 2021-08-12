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

$PKEExemptGroup = Get-ADGroup -Identity 'PKE Exemption' | Select-Object -ExpandProperty DistinguishedName

$PKEExemptUsers = Get-NestedGroupMember -Group $PKEExemptGroup | where {$_.ObjectClass -eq 'User'} | where {$_.Enabled -eq 'True'}
Write-Output "PKE Exempt Users: $(($PKEExemptUsers.samaccountname | select -Unique).count)"
$PKEExemptUsersExempt = Get-NestedGroupMember -Group $PKEExemptGroup | where {$_.ObjectClass -eq 'User'} | where {$_.Enabled -eq 'True'} | Where-Object {!($_.Smartcardlogonrequired)}
Write-Output "PKE Exempt Users Exempt: $(($PKEExemptUsersExempt.samaccountname | select -Unique).count)"
Echo "PKE Exempt Users Exempted:"
Get-NestedGroupMember -Group $PKEExemptGroup | where {$_.ObjectClass -eq 'User'} | Where-Object {!($_.Smartcardlogonrequired)} | Select-Object -Unique | Sort Name | Select DisplayName,SamAccountName, EmailAddress | Export-csv C:\users\hugo.baezurquiola\Desktop\pke_exempt_users.csv
