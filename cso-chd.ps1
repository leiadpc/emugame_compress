# Get all CSO files in a directory
$csoFiles = Get-ChildItem -Path ".\" -Filter "*.cso"

foreach ($csoFile in $csoFiles) {
    # Decompress CSO to ISO
    .\tools\maxcso.exe --decompress $csoFile.FullName
    # Delete CSO file, comment out if you want to keep original files
    Remove-Item $csoFile.FullName 
    # Convert ISO to CHD
    $isoPath = ('.\'+$csoFile.BaseName+'.iso')
    $chdPath = ('.\'+$csoFile.BaseName+'.chd')
    .\tools\chdman.exe createdvd -i $isoPath -o $chdPath
    # Delete ISO file
    Remove-Item $isoPath
}