$subjectline = "Remittance advice","New VoiceMail","Your username and password","Jeff Both Shared New Document with you","Invoice 926/MMQGF4462811407","Missing invoices"
## Wildcards '*' are not required for Subject lines. The search will treat the beginning and end of a provided subject as a wildcard by default. ##

$mailbox = "first.lastname","first.lastname2","SPMAGTF_GCE_S1"

$attachmentlist = "W Co Oct Command Chronology.docx"

## Search specific mailboxes for an attachment ##
## To Delete Contents, replace '-logonly' with '-DeleteContent'
##
## Foreach ($mbx in $mailbox){
##    Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery 'Attachment:"$attachment"' -targetmailbox "administrator.emailaddress" -targetfolder "$mbx - $attachment Search" -logonly -loglevel full
##    }
##
#################################################

## Search specific mailboxes for a subject line ##
## To Delete Contents, replace '-logonly' with '-DeleteContent'
##
## Foreach ($mbx in $subjectline){
##    Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox "administrator.emailaddress" -targetfolder "$mbx - $subject Search" -logonly -loglevel full
##    }
##
##################################################


## Search all mailboxes for anc attachment ##
## To Delete Contents, replace '-logonly' with '-DeleteContent'
##
##  Foreach ($attachment in $attachmentlist){
##    Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery 'Attachment:"$attachment"' -targetmailbox "administrator.emailaddress" -targetfolder "$attachment Search" -logonly -loglevel full
##    }
##
#############################################

## Search all mailboxes for a subject line ##
## To Delete Contents, replace '-logonly' with '-DeleteContent'
##
##  Foreach ($subject in $subjectline){
##    Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox "administrator.emailaddress" -targetfolder "$attachment Search" -logonly -loglevel full
##    }
##
#############################################
