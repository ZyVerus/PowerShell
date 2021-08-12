#-----------------------------------------------#
#                                               #
#   Name: Exchange Spillage Containment         #
#         Scripts                               #
#   Created By: ZyVerus                         #
#   Latest Revision Date: 2019 Feb 26           #
#                                               #
#   In the event of an organizational spillage  #
#   of confidential information, these scripts  #
#   can be utilized to search for an delete     #
#   associated e-mails.                         #
#                                               #
#   To specify subjects, user mailboxes, and    #
#   attachments, it is recommended to only      #
#   modify the variables in lines 22 - 29 and   #
#   remove the comment blocks for the required  #
#   script                                      #
#                                               #
#   For each script, remove only the lines      #
#   with a single '#', and review the options   #
#   for each script to specify whether you      #
#   would like to log only, send a copy of      #
#   e-mails, or delete found contents.          #
#                                               #
#-----------------------------------------------#

## Subjects
$subjectlist = "Remittance advice","New VoiceMail","Your username and password","Jeff Both Shared New Document with you","Invoice 926/MMQGF4462811407","Missing invoices"
## Wildcards '*' are not required for Subject lines. The search will treat the beginning and end of a provided subject as a wildcard by default.

## User Mailboxes
$mailbox = "user.mail1","user.mail2"

## Attachments
$attachmentlist = "Attachment.doc","Attachment2.pdf"

## Target admin mailbox
$adminmailbox = "admin.mail1"


## Title: Search specific mailboxes for an attachment
##
## ~~~~Delete comments below this line with only a single '#'
##
#        Foreach ($mbx in $mailbox){
##
## Options:
##     Default. Send information of matches to admin mailbox. It is recommended to do this first before deleting contents to reduce false-positive matches and e-mail deletions.
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Attachment:$attachmentlist -targetmailbox $adminmailbox -targetfolder "$mbx - $attachmentlist Search" -logonly -loglevel full }
##
##     Send copy of matches to admin mailbox. Be aware that depending on your organization's reporting requirements, this could extend the scope of a spillage. 
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Attachment:$attachmentlist -targetmailbox $adminmailbox -targetfolder "$mbx - $attachmentlist Search" -loglevel full }
##
##     Delete Contents from User Mailboxes
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Attachment:$attachmentlist -targetmailbox $adminmailbox -targetfolder "$mbx - $attachmentlist Search" -DeleteContent -Force } 
##
#################################################

## Title: Search specific mailboxes for a subject line
##
## ~~~~Delete comments below this line with only a single '#'
##
#        Foreach ($mbx in $mailbox){
##
## Options:
##     Default. Send information of matches to admin mailbox. It is recommended to do this first before deleting contents to reduce false-positive matches and e-mail deletions.
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Subject:"$subjectlist" -targetmailbox $adminmailbox -targetfolder "$mbx - $subjectlist Search" -logonly -loglevel full }
##
##     Send copy of matches to admin mailbox. Be aware that depending on your organization's reporting requirements, this could extend the scope of a spillage.
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Subject:"$subjectlist" -targetmailbox $adminmailbox -targetfolder "$mbx - $subjectlist Search" -loglevel full }
##
##     Delete Contents from User Mailboxes
#          Get-Mailbox -Identity $mbx | Search-Mailbox -SearchQuery Subject:"$subjectlist" -targetmailbox $adminmailbox -targetfolder "$mbx - $subjectlist Search" -DeleteContent -Force } 
##
##################################################


## Title: Search all mailboxes for an attachment
##
## ~~~~Delete comments below this line with only a single '#'
##
#        Foreach ($attachment in $attachmentlist){
##
## Options:
##     Default. Send information of matches to admin mailbox. It is recommended to do this first before deleting contents to reduce false-positive matches and e-mail deletions.
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery 'Attachment:"$attachmentlist"' -targetmailbox $adminmailbox -targetfolder "$attachment Search" -logonly -loglevel full }
##
##     Send copy of matches to admin mailbox. Be aware that depending on your organization's reporting requirements, this could extend the scope of a spillage.
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery 'Attachment:"$attachmentlist"' -targetmailbox $adminmailbox -targetfolder "$attachment Search" -loglevel full }
##
##     Delete Contents from User Mailboxes
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery 'Attachment:"$attachmentlist"' -targetmailbox $adminmailbox -targetfolder "$attachment Search" -DeleteContent -Force }
##
#################################################

## Title: Search all mailboxes for a subject line 
##
## ~~~~Delete comments below this line with only a single '#'
##
#        Foreach ($subject in $subjectlist){
##
## Options:
##     Default. Send information of matches to admin mailbox. It is recommended to do this first before deleting contents to reduce false-positive matches and e-mail deletions.
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox $adminmailbox -targetfolder "$subject Search" -logonly -loglevel full }
##
##     Send copy of matches to admin mailbox. Be aware that depending on your organization's reporting requirements, this could extend the scope of a spillage.
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox $adminmailbox -targetfolder "$subject Search" -loglevel full }
##
##     Delete Contents from User Mailboxes
#          Get-Mailbox -ResultSize Unlimited | Search-Mailbox -SearchQuery Subject:"$subject" -targetmailbox $adminmailbox -targetfolder "$subject Search" -DeleteContent -Force }
##
#################################################