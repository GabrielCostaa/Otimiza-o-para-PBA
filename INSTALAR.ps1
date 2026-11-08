# Instalador da Otimizacao (anti-travadas) - Pokemon Battle Advanced 0.3.3
# Troca o video do jogo de Direct3D 12 para Vulkan via override.cfg (nao altera o .exe/.pck).
$ErrorActionPreference = 'Stop'
$exe = 'PokemonBattleAdvanced.exe'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$utf8 = New-Object Text.UTF8Encoding($false)

function Set-CfgKey($path, $section, $key, $value) {
    $lines = New-Object System.Collections.Generic.List[string]
    if (Test-Path $path) { foreach ($l in [IO.File]::ReadAllLines($path)) { $lines.Add($l) } }
    $hdr = "[$section]"; $si = -1
    for ($i = 0; $i -lt $lines.Count; $i++) { if ($lines[$i].Trim() -eq $hdr) { $si = $i; break } }
    if ($si -lt 0) {
        if ($lines.Count -gt 0 -and $lines[$lines.Count - 1].Trim() -ne '') { $lines.Add('') }
        $lines.Add($hdr); $lines.Add("$key=$value")
    } else {
        $end = $lines.Count
        for ($j = $si + 1; $j -lt $lines.Count; $j++) { if ($lines[$j].Trim() -match '^\[') { $end = $j; break } }
        $ki = -1
        for ($j = $si + 1; $j -lt $end; $j++) { if ($lines[$j] -match ('^\s*' + [regex]::Escape($key) + '\s*=')) { $ki = $j; break } }
        if ($ki -ge 0) { $lines[$ki] = "$key=$value" }
        else {
            $ins = $end
            while ($ins -gt $si + 1 -and $lines[$ins - 1].Trim() -eq '') { $ins-- }
            $lines.Insert($ins, "$key=$value")
        }
    }
    [IO.File]::WriteAllText($path, (($lines -join "`n") + "`n"), $utf8)
}

function Find-Game {
    foreach ($c in @($here, (Split-Path -Parent $here))) {
        if ($c -and (Test-Path (Join-Path $c $exe))) { return $c }
    }
    Add-Type -AssemblyName System.Windows.Forms
    $d = New-Object System.Windows.Forms.FolderBrowserDialog
    $d.Description = "Selecione a pasta do jogo (a que contem $exe)"
    if ($d.ShowDialog() -eq 'OK' -and (Test-Path (Join-Path $d.SelectedPath $exe))) { return $d.SelectedPath }
    return $null
}

Write-Host ''
Write-Host '=== Otimizacao anti-travadas - Pokemon Battle Advanced ===' -ForegroundColor Yellow
$game = Find-Game
if (-not $game) { Write-Host "Pasta do jogo nao encontrada ($exe)." -ForegroundColor Red; exit 1 }
Write-Host "Jogo encontrado em: $game"

$cfg = Join-Path $game 'override.cfg'
Set-CfgKey $cfg 'rendering' 'rendering_device/driver.windows' '"vulkan"'

Write-Host ''
Write-Host 'Otimizacao instalada!' -ForegroundColor Green
Write-Host 'O jogo agora usa Vulkan (em vez de Direct3D 12): bem menos engasgos ao andar.'
Write-Host 'Na primeira vez pode haver alguns engasgos enquanto o cache de shaders e criado.'
