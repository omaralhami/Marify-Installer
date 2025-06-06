$ErrorActionPreference = 'Stop'

Write-Host "Welcome to Marify Pro Installer" -ForegroundColor Cyan
Write-Host "Please enter your access password to continue" -ForegroundColor Cyan
Write-Host

$maxAttempts = 3
$attempts = 0
$correctPassword = "MarifyPro2024!"  # Your password for agents

while ($attempts -lt $maxAttempts) {
    $password = Read-Host "Enter password" -AsSecureString
    $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
    $enteredPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
    
    if ($enteredPassword -eq $correctPassword) {
        Write-Host
        Write-Host "Access granted!" -ForegroundColor Green
        Write-Host "Starting installation..." -ForegroundColor Cyan
        Write-Host
        
        try {
            # Download and execute the main installer
            $command = "iex `"& { $(iwr -useb 'https://raw.githubusercontent.com/omaralhami/Marify/main/run.ps1') } -new_theme`""
            Invoke-Expression $command
            exit 0
        }
        catch {
            Write-Host "Error during installation: $_" -ForegroundColor Red
            Write-Host "Please contact support on Discord for assistance" -ForegroundColor Yellow
            exit 1
        }
    }
    
    $attempts++
    $remainingAttempts = $maxAttempts - $attempts
    Write-Host
    Write-Host "Access denied - Invalid password" -ForegroundColor Red
    if ($remainingAttempts -gt 0) {
        Write-Host "Please try again. Remaining attempts: $remainingAttempts" -ForegroundColor Yellow
        Write-Host
    }
}

Write-Host
Write-Host "Maximum password attempts exceeded. Installation aborted." -ForegroundColor Red
Write-Host "Please contact support to obtain valid credentials." -ForegroundColor Yellow
exit 1 
