<#
Ping-List.ps1

.SYNOPSIS
  Powershell script to ping some or all the IP addresses inside a CSV file.
  
.DESCRIPTION
  This PowerShell script reads a CSV file and pings the IP addresses listed in the IPAddress column.

.NOTES
  Author:         Romel Vera
  Creation Date:  November 5 2021
  Version:        1.0.3

.LINK
  https://www.github.com/romelsan

.PARAMETER -file <csvfile>
  File name and path of the CSV file to read.
  Default file is "IPList.csv"

.PARAMETER -showtable
  If present it outputs in the console the table data from the CSV file.

.PARAMETER -location "<Location>"
  If present it filters the location hosts to ping.
  If NOT present then it pings all the hosts in the list.

.PARAMETER -writelog
  If present it writes the results inside a txt file.

.EXAMPLE
  Ping-List.ps1 -showtable

.NOTES
The CSV file must have as headers: HostName,IPAddress,Location
#>
# ------------------------------------------------------------------------

# Parameters Section
param ($file="IPList.csv",[Switch]$showtable,$location="All",[Switch]$writelog)
if (-not(Test-Path -Path $file -PathType Leaf)) {
    $file = read-host -Prompt "Please enter a csv filename: " 
}
if ($file -eq $null) {
    $file = read-host -Prompt "Please enter a csv filename: " 
}

# If showtable is present in arguments
if ($PSBoundParameters.ContainsKey('showtable')){
    $showtablecontents = "True"
}

# If writelog is present in arguments
if ($PSBoundParameters.ContainsKey('writelog')){
  $writetofile = "True"
}

# Main
$ColumnHeader = "IPAddress"

Write-Host "Reading file" $file

if ($location -eq "All"){
    $ipaddresses = import-csv $file | select-object $ColumnHeader
    if ($showtablecontents -eq "True") {Import-Csv $file | Format-Table }
}

else {
    $ipaddresses = import-csv $file | where-object {$_.Location -eq "$location"} | select-object $ColumnHeader 
    if ($showtablecontents -eq "True") {Import-Csv $file | where-object {$_.Location -eq "$location"} | Format-Table }
}

# Task
Write-Host "Starting...`r`n" 
foreach( $ip in $ipaddresses) {
    if (test-connection $ip.("IPAddress") -count 1 -quiet) {
        $textoutput = $ip.("IPAddress") + " OK."
        write-host $textoutput -foreground green
        $result += $textoutput + "`r`n"
    } else {
        $textoutput = $ip.("IPAddress") + " FAIL."
        write-host $textoutput -foreground red
        $result += $textoutput + "`r`n"
    }
    
}

# Log
if ($writetofile -eq "True") {
    $start = Get-Date -format "dd-MMM-yyyy HH:mm"
    Add-Content -Path log.txt -Value $start
    Add-Content -Path log.txt -Value $result
}

Write-Host "`r`nTask Completed."
