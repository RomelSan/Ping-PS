# Ping-PS

 PowerShell script to ping some or all the IP addresses inside a CSV file.

## Description

 This PowerShell script reads a CSV file and pings the IP addresses listed in the IPAddress column.

## Parameters

```powershell
Ping-v3.ps1 -file <csvfile>
```

 File name and path of the CSV file to read.

 Default file is "IPList.csv"

**-showtable**

 If present it outputs in the console the table data from the CSV file.

**-location "<Location>"**

 If present it filters the location hosts to ping.

 If NOT present then it pings all the hosts in the list.

**-writelog**

 If present it writes the results inside a log.txt file.

## CSV File

The CSV file must have headers: HostName,IPAddress,Location

![csv](./screenshots/csv.png?RAW=TRUE)

## EXAMPLE

**Example 1**

Ping all the hosts inside "IPList.csv", also show the csv table in console.

```powershell
Ping-v3.ps1 -showtable
```

![Example1](./screenshots/Terminal1.png?RAW=TRUE)

**Example 2**

Ping all the hosts inside "IPList.csv", also show the csv table in console and ping only the ones inside location "ESXi"

```powershell
Ping-v3.ps1 -showtable -location "ESXi"
```

![Example2](./screenshots/Terminal2.png?RAW=TRUE)

### Requires:

- Windows 10 / Windows 11

### Contact

Twitter: [@RomelSan](http://www.twitter.com/RomelSan)    
Date: November 6, 2021

### License

MIT License

---

## Troubleshoot

If you are new to PowerShell then it is possible that you can't run scripts because of the execution policy.

Open PowerShell as administrator.

To view the current policy type:

```powershell
Get-ExecutionPolicy
```

Take note of this, in most cases it will be "Restricted".

If you want to run PowerShell scripts then you must set this to:

```powershell
Set-ExecutionPolicy RemoteSigned
```

If you have problems then try to use `Set-ExecutionPolicy Unrestricted` just for testing, then set this setting to RemoteSigned parameter.

Then try to run the script.

If you are not using scripts or just to revert this setting then type:

```powershell
Set-ExecutionPolicy Restricted
```

