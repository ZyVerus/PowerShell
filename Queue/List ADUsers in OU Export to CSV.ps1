$ADUserParams=@{ 
'Server' = 'MENBAH02DC.me.usmc.mil' 
'Searchbase' = 'OU=SPMAGTF,OU=ME User Catalog,DC=me,DC=usmc,DC=mil' 
'Searchscope'= 'Subtree' 
'Filter' = '*' 
'Properties' = '*' 
} 
 
#This is where to change if different properties are required. 
 
$SelectParams=@{ 
'Property' = 'SAMAccountname', 'Surname', 'GivenName', 'Initials', 'CN', 'SmartcardLogonRequired', 'title', 'DisplayName', 'Description', 'EmailAddress', 'employeeID', 'Employeenumber', 'enabled', 'lockedout', 'lastlogondate', 'badpwdcount', 'passwordlastset', 'created' 
} 
 
get-aduser @ADUserParams | select-object @SelectParams  | export-csv "c:\users\hugo.baezurquiola\desktop\spmagtf_users_20180507.csv"