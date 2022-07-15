import subprocess

cmd = ['powershell.exe', 'Get-CimInstance', 'Win32_Product', '|', 'Sort-Object', '-property', 'Name', '|', 'Format-Table', '-Property', 'Version,', 'Name']
software_list = subprocess.run(cmd, stdout=subprocess.PIPE, text=True)

print(software_list.stdout)