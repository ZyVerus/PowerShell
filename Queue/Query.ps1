$db = Get-MailboxDatabase

foreach ($server in $db){
    Get-Mailbox -server $server.server | Search-Mailbox -SearchQuery 'Attachment:"Filename.extn"' -targetMailbox admin.mailboxaddress -TargetFolder AttachmentSearchEveryone -LogLevel Full -Verbose
    }