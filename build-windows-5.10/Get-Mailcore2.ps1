Param(
    [string]$InstallPath
)

$ProjectRoot = "$(Resolve-Path ""$PSScriptRoot\..\"")"

if (-Not $InstallPath) {
    $InstallPath = "$ProjectRoot\.build\install"
}

$PrebuiltMailcoreVersion = 4
$PrebuiltMailcoreArchive = "mailcore2-all-$PrebuiltMailcoreVersion.zip"
$PrebuiltMailcoreUrl = "https://spark-prebuilt-binaries.s3.amazonaws.com/$PrebuiltMailcoreArchive"

$S3Key = $env:SPARK_PREBUILT_KEY
if (!$S3Key) {
    throw "Spark prebuilt storage key(SPARK_PREBUILT_KEY) is required"
}

Push-Task -Name "mailcore2" -ScriptBlock {
    Push-Task -Name "Initialize" -ScriptBlock {
        Write-TaskLog "Working in $ProjectRoot"
        Push-Location -Path $ProjectRoot
    }

    try {
        $TempDir = [System.IO.Path]::GetTempFileName()
        Remove-Item $TempDir
        
        $TempFile = "$TempDir.zip"
        
        Write-TaskLog "Downloading $PrebuiltMailcoreUrl to $TempFile"

        Invoke-RestMethod -Uri $PrebuiltMailcoreUrl -OutFile $TempFile -UserAgent $S3Key
        Remove-Item $TempDir -Force -Recurse -ErrorAction Ignore
        New-Item -ItemType Directory $TempDir
        Write-TaskLog "Extracting $TempFile to $TempDir"
        tar -C "$TempDir" -xf "$TempFile"
        
        New-Item -Path $InstallPath -ItemType Directory -ErrorAction Ignore
        Get-ChildItem -Path "$TempDir\mailcore2-all" | Copy-Item -Destination $InstallPath -Recurse -Container -PassThru -Force | Write-Host
        
        Write-TaskLog "Deleting $TempFile"
        Remove-Item $TempFile -Force
        Write-TaskLog "Deleting $TempDir"
        Remove-Item $TempDir -Force -Recurse
    }
    finally {
        Push-Task -Name "Shutdown" -ScriptBlock {
            Pop-Location
        }
    }
}