$zipFiles = Get-ChildItem -Path ".\" -Filter "*.zip"
foreach ($zipFile in $zipFiles) {
    If ((.\tools\7z.exe t $zipFile -r *) -notcontains "Everything is Ok"){
        Write-Error ($zipFile.Basename+": Could not extract, file possibly corupt")}
    else{
    .\tools\7z.exe x $zipFile.FullName -o".\.temp"
    $7zFile = ('..\'+$zipFile.BaseName+'.7z')
    Set-Location ".\.temp"
    $content = Get-ChildItem
    ..\tools\7z.exe a -t7z -mx9 $7zFile $content
    if ((..\tools\7z.exe t $7zFile -r *) -notcontains "Everything is Ok") {
        Write-Error ($zipFile.Basename+" Compression failed")
        Remove-Item -Force $7zFile
        Set-Location ..
        Remove-Item -Recurse -Force ".\.temp"
    }
    else {
        Set-Location ..
        Remove-Item -Recurse -Force ".\.temp"\
        # Comment out next line to keep original zip file
        Remove-Item $zipFile.FullName        
}}}