$subjectline = "SPMAGTF CRCC HMSAS POC"
Foreach ($subject in $subjectline){
    Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox "hugo.baezurquiola" -targetfolder "$subject - Initial" -loglevel full
    }