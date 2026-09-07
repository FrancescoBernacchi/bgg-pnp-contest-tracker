param(
    [int]$Port = 8765,
    [string]$Database = (Join-Path $PSScriptRoot '..\database\pnp_collection.sqlite3'),
    [string]$PythonPath
)
$ErrorActionPreference = 'Stop'
if (-not $PythonPath) {
    $candidate = Get-Command python -ErrorAction SilentlyContinue
    if ($candidate -and $candidate.Source -notlike '*WindowsApps*') {
        $PythonPath = $candidate.Source
    } else {
        $bundled = Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
        if (Test-Path -LiteralPath $bundled) { $PythonPath = $bundled }
    }
}
if (-not $PythonPath) {
    throw 'Python non trovato. Installare Python 3.12+ oppure specificare -PythonPath con il percorso di python.exe.'
}
Write-Host "Avvio locale: http://127.0.0.1:$Port — Ctrl+C per arrestare."
& $PythonPath (Join-Path $PSScriptRoot 'server.py') --database $Database --port $Port
exit $LASTEXITCODE
