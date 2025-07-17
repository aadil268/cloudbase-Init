# install-cloudbase-init.ps1

$ErrorActionPreference = "Stop"

# Variables
$cloudbaseInstallerUrl = "https://cloudbase.it/downloads/CloudbaseInitSetup_Beta_x64.msi"
$installerPath = "C:\CloudbaseInitSetup.msi"
$cloudinitScriptUrl = "https://raw.githubusercontent.com/aadil268/cloudbase-Init/main/cloudinit.ps1"
$cloudinitScriptPath = "C:\cloudinit.ps1"
$cloudbaseUnattendPath = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\unattend.xml"
$customDataPath = "C:\AzureData\CustomData.bin"
$cloudbaseInitExe = "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\cloudbase-init.exe"

# Step 1: Download and install Cloudbase-Init
Write-Output "Downloading Cloudbase-Init..."
Invoke-WebRequest -Uri $cloudbaseInstallerUrl -OutFile $installerPath

Write-Output "Installing Cloudbase-Init..."
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$installerPath`" /qn"

# Step 2: Decode CustomData.bin to unattend.xml
if (Test-Path $customDataPath) {
    Write-Output "Extracting unattend.xml from CustomData.bin..."
    $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String((Get-Content $customDataPath)))
    $decoded | Out-File -FilePath $cloudbaseUnattendPath -Encoding UTF8 -Force
} else {
    Write-Warning "CustomData.bin not found at $customDataPath"
}

# Step 3: Download cloudinit.ps1
Write-Output "Downloading cloudinit.ps1..."
Invoke-WebRequest -Uri $cloudinitScriptUrl -OutFile $cloudinitScriptPath

# Step 4: Set execution policy
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Step 5: Run Cloudbase-Init explicitly
if (Test-Path $cloudbaseInitExe) {
    Write-Output "Running Cloudbase-Init with --unattend..."
    & "$cloudbaseInitExe" --unattend
} else {
    Write-Warning "cloudbase-init.exe not found. Falling back to manual script execution."
    Write-Output "Running cloudinit.ps1 manually..."
    powershell.exe -ExecutionPolicy Bypass -File $cloudinitScriptPath
}

# Step 6: Start service for next boot (optional)
Start-Service cloudbase-init

Write-Output "Setup complete."