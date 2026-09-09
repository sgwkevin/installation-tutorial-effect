param(
  [Parameter(Mandatory = $true)][string]$FinalVideo,
  [string]$ArchiveRoot = 'D:\视频素材',
  [datetime]$ArchiveDate = (Get-Date)
)

$ErrorActionPreference = 'Stop'

$source = (Resolve-Path -LiteralPath $FinalVideo).Path
if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Final video not found: $FinalVideo" }

if (-not (Test-Path -LiteralPath $ArchiveRoot -PathType Container)) {
  New-Item -ItemType Directory -Path $ArchiveRoot | Out-Null
}

$folderName = '{0}.{1}' -f $ArchiveDate.Month, $ArchiveDate.Day
$dateFolder = Join-Path $ArchiveRoot $folderName
if (-not (Test-Path -LiteralPath $dateFolder -PathType Container)) {
  New-Item -ItemType Directory -Path $dateFolder | Out-Null
}

$leaf = [IO.Path]::GetFileName($source)
$stem = [IO.Path]::GetFileNameWithoutExtension($leaf)
$extension = [IO.Path]::GetExtension($leaf)
$destination = Join-Path $dateFolder $leaf
$version = 2

while (Test-Path -LiteralPath $destination) {
  $destination = Join-Path $dateFolder ('{0}-v{1}{2}' -f $stem, $version, $extension)
  $version++
}

Copy-Item -LiteralPath $source -Destination $destination
Write-Output $destination
