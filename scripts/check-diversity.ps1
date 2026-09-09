param(
  [Parameter(Mandatory = $true)][string]$Storyboard,
  [Parameter(Mandatory = $true)][string]$History,
  [double]$MaxOverlap = 0.70
)

$ErrorActionPreference = 'Stop'

function Get-Token($shot) {
  $source = [string]$shot.source
  $start = if ($null -ne $shot.source_start) { [double]$shot.source_start } else { [double]$shot.start }
  $end = if ($null -ne $shot.source_end) { [double]$shot.source_end } else { [double]$shot.end }
  return ('{0}|{1:F2}|{2:F2}' -f $source.ToLowerInvariant(), $start, $end)
}

$board = Get-Content -LiteralPath $Storyboard -Raw | ConvertFrom-Json
$currentShots = @($board.shots)
if ($currentShots.Count -eq 0) { throw 'Storyboard contains no shots.' }
$current = @($currentShots | ForEach-Object { Get-Token $_ })

if (-not (Test-Path -LiteralPath $History)) {
  [pscustomobject]@{ passes = $true; exact_sequence_match = $false; max_overlap = 0; compared_edits = 0 } | ConvertTo-Json
  exit 0
}

$historyData = Get-Content -LiteralPath $History -Raw | ConvertFrom-Json
$edits = if ($historyData -is [System.Array]) { @($historyData) } else { @($historyData.edits) }
$maxFound = 0.0
$exact = $false
$exactId = $null

foreach ($edit in $edits) {
  $previous = @($edit.shots | ForEach-Object { Get-Token $_ })
  if ($previous.Count -eq 0) { continue }
  if (($current -join "`n") -eq ($previous -join "`n")) { $exact = $true; $exactId = $edit.output_id }
  $matches = 0
  foreach ($token in $current) { if ($previous -contains $token) { $matches++ } }
  $overlap = $matches / [math]::Max($current.Count, 1)
  if ($overlap -gt $maxFound) { $maxFound = $overlap }
}

$passes = (-not $exact) -and ($maxFound -le $MaxOverlap)
[pscustomobject]@{
  passes = $passes
  exact_sequence_match = $exact
  exact_match_output_id = $exactId
  max_overlap = [math]::Round($maxFound, 3)
  allowed_overlap = $MaxOverlap
  compared_edits = $edits.Count
} | ConvertTo-Json

if (-not $passes) { exit 2 }
