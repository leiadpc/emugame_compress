#
#
#function cd2chd {}
function cso2chd {
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
}
#function cue2chd {}
#function dvd2chd{}
#function iso2rvz {}
function xiso2zar {
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
}
