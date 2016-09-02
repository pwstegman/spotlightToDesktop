$key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative'
$picture = (Get-ItemProperty -Path $key -Name LandscapeAssetPath).LandscapeAssetPath
$date = Get-Date -UFormat "%Y%m%d"
$jpg = "$date.jpg"
$savePath = "C:\Users\[username]\Pictures\Spotlight\$jpg"
if(!(Test-Path $savePath)){
    cp $picture $savePath
    Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $savePath
    rundll32.exe user32.dll, UpdatePerUserSystemParameters
    echo "Set desktop background"
}else{
    echo "Desktop background already set"
}
