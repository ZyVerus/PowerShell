Invoke-Command -ComputerName ####### -ScriptBlock {
Get-WmiObject -Class Win32Reg_AddRemovePrograms | Export-Csv "20180517A.csv"
}