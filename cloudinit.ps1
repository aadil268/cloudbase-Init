# cloudinit.ps1
Write-Output "Running PowerShell script via Cloudbase-Init..." | Out-File -FilePath C:\Cloudbase-Init-Log.txt -Append
New-Item -Path "C:\Demo" -ItemType Directory -Force
"Script executed successfully on $(Get-Date)" | Out-File C:\Demo\status.txt