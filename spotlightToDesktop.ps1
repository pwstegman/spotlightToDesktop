Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper{
    public class Setter {
        [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
        private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
        public static void SetWallpaper ( string path ) {
            SystemParametersInfo( 20, 0, path, 0x01 | 0x02 );
            RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
            key.SetValue(@"WallpaperStyle", "10");
            key.SetValue(@"TileWallpaper", "0");
            key.Close();
        }
    }
}
"@
#Code for the namespace Wallpaper modified from http://poshcode.org/491

$key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative'
$picture = (Get-ItemProperty -Path $key -Name LandscapeAssetPath).LandscapeAssetPath
$name = Split-Path -Path $picture -Leaf
$jpg = "$name.jpg"
$savePath = "C:\Users\[username]]\Pictures\Spotlight\$jpg"
if(!(Test-Path $savePath)){
    cp $picture $savePath
    echo "Copied over new Spotlight image"
}
[Wallpaper.Setter]::SetWallpaper( $savePath )
echo "Set desktop background"
