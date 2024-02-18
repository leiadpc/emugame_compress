# Get all ISO files in a directory
$isoFiles = Get-ChildItem -Path ".\" -Filter "*.iso"

foreach ($isoFile in $isoFiles) {
    # Decompress ISO to folder
    .\tools\extract-xiso.exe -x $isoFile.FullName
    # # Delete ISO file, comment out if you want to keep original files
    Remove-Item $isoFile.FullName 
    # Compress extracted files to ZAR
    $dirPath = ('.\'+$isoFile.BaseName)
    $zarPath = ('.\'+$isoFile.BaseName+'.zar')
    .\tools\zarchive.exe $dirPath $zarPath
    # Delete extracted files
    Remove-Item -Recurse -Force $dirPath
}