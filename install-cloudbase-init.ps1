# install-cloudbase-init.ps1

$installerUrl = "https://cloudbase.it/downloads/CloudbaseInitSetup_Beta_x64.msi"
$installerPath = "C:\CloudbaseInitSetup.msi"

Invoke-WebRequest -Uri $installerUrl -OutFile $installerPath
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$installerPath`" /qn"

# Replace default config if needed
Copy-Item -Path "C:\AzureData\CustomData.bin" -Destination "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\unattend.xml" -Force

# Ensure service is running
Start-Service cloudbase-init