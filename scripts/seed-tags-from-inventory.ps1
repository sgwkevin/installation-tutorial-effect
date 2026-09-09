param(
  [Parameter(Mandatory = $true)][string]$Inventory,
  [Parameter(Mandatory = $true)][string]$Output
)

$ErrorActionPreference = 'Stop'
$items = Get-Content -LiteralPath $Inventory -Raw | ConvertFrom-Json

$records = foreach ($item in $items) {
  $tags = switch ([string]$item.category) {
    '白天搭建' { @('setup', 'day') }
    '放置灯光操作' { @('installation', 'product-closeup') }
    '遥控控制' { @('control-candidate') }
    '局部灯光效果' { @('effect', 'closeup') }
    '夜晚灯光闪烁效果' { @('effect', 'color-change-candidate') }
    '夜晚整体大效果' { @('effect', 'wide-result') }
    default { @('unclassified') }
  }

  [pscustomobject]@{
    asset_id = [IO.Path]::GetFileNameWithoutExtension([string]$item.path)
    path = [string]$item.path
    source_start = 0.0
    source_end = [double]$item.duration
    media_type = 'video'
    scene_tags = $tags
    lighting = if ([string]$item.category -like '白天*') { 'day' } elseif ([string]$item.category -like '夜晚*') { 'night' } else { 'unknown' }
    colors = @()
    control_method = 'unknown'
    app_visible = 'unknown'
    remote_visible = 'unknown'
    hook_strength = 0
    quality = 'candidate'
    rights = 'user-provided'
    notes = 'Folder-level seed tag; visual review required.'
  }
}

$records | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $Output -Encoding utf8
Write-Output $Output
