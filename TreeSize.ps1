$RootFolder = "x:\"
$FoldersSizeList = @()

Get-ChildItem -Force $RootFolder -ErrorAction SilentlyContinue -Directory | foreach{

   $Size = 0
   $Size = (Get-ChildItem $_.Fullname -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum

   $FolderName = $_.fullname

   $FolderSize= [math]::Round($Size / 1Mb,2)

   $FoldersSizeListObject = New-Object PSObject
   Add-Member -InputObject $FoldersSizeListObject -MemberType NoteProperty -Name "Dossier" -value $FolderName
   Add-Member -InputObject $FoldersSizeListObject -MemberType NoteProperty -Name "Taille-Mb" -value $FolderSize
   $FoldersSizeList += $FoldersSizeListObject
}

$FoldersSizeList | Out-GridView -Title "Taille des dossiers sous $RootFolder"
