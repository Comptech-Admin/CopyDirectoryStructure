# Prompt the user for the source directory path
$source = Read-Host -Prompt "Enter the source directory path"

# Prompt the user for the target directory path
$destination = Read-Host -Prompt "Enter the target directory path"

# Create the destination directory if it doesn't exist
if (-Not (Test-Path -Path $destination)) {
    New-Item -ItemType Directory -Path $destination
}

# Recursively create the directory structure
Get-ChildItem -Path $source -Recurse -Directory | ForEach-Object {
    $relativePath = $_.FullName.Substring($source.Length).TrimStart('\')
    $targetPath = Join-Path -Path $destination -ChildPath $relativePath
    if (-Not (Test-Path -Path $targetPath)) {
        New-Item -ItemType Directory -Path $targetPath
    }
}

Write-Host "Directory structure copied successfully from $source to $destination"