# Simple PowerShell static file server using HttpListener
# Usage: powershell -NoProfile -ExecutionPolicy Bypass -File .\serve.ps1

param(
  [int]$Port = 8000
)

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$prefix = "http://localhost:$Port/"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
try {
  $listener.Start()
} catch {
  # Use a simple ASCII-only message to avoid parsing/encoding issues
  $errMsg = "Failed to start HttpListener on $prefix. Run PowerShell as Administrator or pick a different port."
  Write-Error $errMsg
  Write-Error $_
  exit 1
}
Write-Host "Serving files from: $root"
Write-Host "Listening on http://localhost:$Port/ - press Ctrl+C to stop"

while ($listener.IsListening) {
  $context = $listener.GetContext()
  $req = $context.Request
  $resp = $context.Response
  $localPath = $req.Url.LocalPath.TrimStart('/')
  if ([string]::IsNullOrEmpty($localPath)) { $localPath = 'index.html' }
  $file = Join-Path $root $localPath
  if (Test-Path $file) {
    try {
      $bytes = [System.IO.File]::ReadAllBytes($file)
      switch -Regex ($file) {
        '\.css$' { $resp.ContentType = 'text/css'; break }
        '\.html?$' { $resp.ContentType = 'text/html'; break }
        '\.js$' { $resp.ContentType = 'application/javascript'; break }
        '\.png$' { $resp.ContentType = 'image/png'; break }
        '\.jpe?g$' { $resp.ContentType = 'image/jpeg'; break }
        default { $resp.ContentType = 'application/octet-stream' }
      }
      $resp.ContentLength64 = $bytes.Length
      $resp.OutputStream.Write($bytes,0,$bytes.Length)
    } catch {
      $resp.StatusCode = 500
      $msg = "Server error: $_"
      $buf = [System.Text.Encoding]::UTF8.GetBytes($msg)
      $resp.ContentType = 'text/plain'
      $resp.ContentLength64 = $buf.Length
      $resp.OutputStream.Write($buf,0,$buf.Length)
    }
  } else {
    $resp.StatusCode = 404
    $buf = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
    $resp.ContentType = 'text/plain'
    $resp.ContentLength64 = $buf.Length
    $resp.OutputStream.Write($buf,0,$buf.Length)
  }
  $resp.OutputStream.Close()
}

$listener.Stop()
$listener.Close()
