# Powershell script to add and/or modify registry values of the local machine
# Edit $namelist and $RegList to change the names and keys created or modified
# Beware: Rough and full of scraps, feel free to use this to edit other keys

# List of names for registy entries
#$namelist = ()

# name should be set to "Enabled" for it to work
$name = 'Enabled'

# Registry paths, can be existing keys or new keys
# $([char]0x2215) is used to add a slash, because editing registry does not allow for escaping slash characters
$RegList = ("HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128$([char]0x2215)128","HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40$([char]0x2215)128","HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56$([char]0x2215)128")

# Variable used for enumerating through name list
#$n = 0


foreach ($key in $RegList) {

    # Test if key already exists. If not create then modify key. Else, modify  key.
    if(!(Test-Path $key)) {

        New-Item -Path $key -Force | Out-Null
        New-ItemProperty -Path $key -Name $name -value '0' -PropertyType DWORD -Force | out-null

    } else {

        New-ItemProperty -Path $key -Name $name -value '0' -PropertyType DWORD -Force | out-null

    }

    #$n += 1
}

# ([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128') 
# Invoke-command -ComputerName "" -ScriptBlock { New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null }
	
# ([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128') 
# Invoke-command -ComputerName "" -ScriptBlock { New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null }
	
# ([Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$env:COMPUTERNAME)).CreateSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128') 
# Invoke-command -ComputerName "" -ScriptBlock { New-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -name 'Enabled' -value '0' -PropertyType 'DWord' -Force | Out-Null }

# Sources/help:
# https://stackoverflow.com/questions/18218835/how-to-create-a-registry-entry-with-a-forward-slash-in-the-name
# https://stackoverflow.com/questions/16149175/creating-a-registry-key-with-path-components-via-powershell
# https://devblogs.microsoft.com/scripting/update-or-add-registry-key-value-with-powershell/