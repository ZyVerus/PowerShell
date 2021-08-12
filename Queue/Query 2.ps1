$mailboxes = "jose.montanez","SPMAGTF_GCE_S1"
Foreach ($mailbox in $mailboxes){
    Get-Mailbox -Identity $mailbox | Search-Mailbox -SearchQuery 'Attachment:"W Co Oct Command Chronology.docx"' -targetmailbox "hugo.baezurquiola" -targetfolder "SPMAGTF Spillage 2018 Nov 6 Part VI" -DeleteContent -loglevel full
    }