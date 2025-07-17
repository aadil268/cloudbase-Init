# install-cloudbase-init.ps1

$ErrorActionPreference = "Stop"

# Variables
$cloudbaseInstallerUrl = "https://cloudbase.it/downloads/CloudbaseInitSetup_1_1_6_x64.msi"
$installerPath = "C:\CloudbaseInitSetup.msi"
$cloudinitScriptUrl = "https://raw.githubusercontent.com/aadil268/cloudbase-Init/main/cloudinit.ps1"
$cloudinitScriptPath = "C:\cloudinit.ps1"
$unattendPath = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\unattend.xml"
$customDataPath = "C:\AzureData\CustomData.bin"

# Download and install Cloudbase-Init
Write-Output "Downloading Cloudbase-Init installer..."
Invoke-WebRequest -Uri $cloudbaseInstallerUrl -OutFile $installerPath

Write-Output "Installing Cloudbase-Init..."
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$installerPath`" /qn"

# Replace default unattend config with the one from customData
if (Test-Path $customDataPath) {
    Write-Output "Applying unattend.xml from customData..."
    Copy-Item -Path $customDataPath -Destination $unattendPath -Force
} else {
    Write-Output "CustomData not found at $customDataPath"
}

# Download cloudinit.ps1
Write-Output "Downloading cloudinit.ps1..."
Invoke-WebRequest -Uri $cloudinitScriptUrl -OutFile $cloudinitScriptPath

# Ensure the script is executable
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Start Cloudbase-Init service
Write-Output "Starting Cloudbase-Init service..."
Start-Service cloudbase-init

Write-Output "Installation and configuration completed."