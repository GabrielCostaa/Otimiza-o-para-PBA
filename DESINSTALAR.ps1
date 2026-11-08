# Desinstalador da Otimizacao - Pokemon Battle Advanced 0.3.3
$ErrorActionPreference = 'Stop'
$exe = 'PokemonBattleAdvanced.exe'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = New-Object Text.UTF8Encoding($false)

function Remove-CfgKey($path, $section, $key) {
    if (-not (Test-Path $path)) { return }
    $lines = New-Object System.Collections.Generic.List[string]
    foreach ($l in [IO.File]::ReadAllLines($path)) { $lines.Add($l) }
    $hdr = "[$section]"; $si = -1
    for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i].Trim() -eq $hdr) { $si = $i; break } }
    if ($si -ge 0) {
        $end = $lines.Count
        for ($j = $si + 1; $j -lt $lines.Count; $j++) { if ($lines[$j].Trim() -match '^\[') { $end = $j; break } }
        for ($j = $end - 1; $j -gt $si; $j--) { if ($lines[$j] -match ('^\s*' + [regex]::Escape($key) + '\s*=')) { $lines.RemoveAt($j) } }
        # remove a secao se sobrou vazia
        $end = $lines.Count
        for ($j = $si + 1; $j -lt $lines.Count; $j++) { if ($lines[$j].Trim() -match '^\[') { $end = $j; break } }
        $vazia = $true
        for ($j = $si + 1; $j -lt $end; $j++) { if ($lines[$j].Trim() -ne '') { $vazia = $false } }
        if ($vazia) { $lines.RemoveRange($si, $end - $si) }
    }
    if (($lines | Where-Object { $_.Trim() -ne '' }).Count -eq 0) { Remove-Item $path -Force }
    else { [IO.File]::WriteAllText($path, ((($lines -join "`n").TrimEnd()) + "`n"), $utf8) }
}

$game = $null
foreach ($c in @($here, (Split-Path -Parent $here))) {
    if ($c -and (Test-Path (Join-Path $c $exe))) { $game = $c; break }
}
if (-not $game) {
    Add-Type -AssemblyName System.Windows.Forms
    $d = New-Object System.Windows.Forms.FolderBrowserDialog
    $d.Description = "Selecione a pasta do jogo (a que contem $exe)"
    if ($d.ShowDialog() -eq 'OK' -and (Test-Path (Join-Path $d.SelectedPath $exe))) { $game = $d.SelectedPath }
}
if (-not $game) { Write-Host 'Pasta do jogo nao encontrada.' -ForegroundColor Red; exit 1 }

Remove-CfgKey (Join-Path $game 'override.cfg') 'rendering' 'rendering_device/driver.windows'
Write-Host 'Otimizacao removida. O jogo voltou a usar o video padrao (Direct3D 12).' -ForegroundColor Green
