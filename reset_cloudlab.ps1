# reset_cloudlab.ps1
# Clean and reinitialize a Git repo after a secret was committed

# Define paths
$repoPath = "$PWD"
$backupPath = "$repoPath-clean-backup"

# Step 1: Backup files (excluding .git)
Write-Host "Backing up files to: $backupPath"
New-Item -ItemType Directory -Force -Path $backupPath
Copy-Item -Recurse "$repoPath\*" -Destination $backupPath -Force -Exclude ".git"

# Step 2: Delete Git history
Write-Host "Deleting .git folder"
Remove-Item -Recurse -Force "$repoPath\.git"

# Step 3: Reinitialize Git repo
Write-Host "Reinitializing Git repository"
Set-Location $repoPath
git init
git remote add origin https://github.com/TalYanai/CloudLab.git
git checkout -b main

# Step 4: Add files and commit
Write-Host "Adding all files and committing"
git add .
git commit -m "Clean reset with secrets properly handled"

# Step 5: Force push to GitHub
Write-Host "Force pushing to GitHub"
git push origin main --force

# Final message
Write-Host "Done. Repository has been cleaned and pushed successfully."
