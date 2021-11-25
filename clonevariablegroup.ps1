# Get the variable group in projectA
$url = "https://dev.azure.com/organization/projectA/_apis/distributedtask/variablegroups/1?api-version=5.1-preview.1"

$PAT = ""

$base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$($PAT)"))

$result=Invoke-RestMethod -Uri $url -Headers @{Authorization = ("Basic {0}" -f $base64AuthInfo)} -Method get -ContentType "application/json" 

# Call add variable group rest api to add variable group in ProjectB
$updateurl = "https://dev.azure.com/organization/projectB/_apis/distributedtask/variablegroups?api-version=5.1-preview.1"

$body = $result | ConvertTo-Json -Depth 10

Invoke-RestMethod -Uri $updateurl -Headers @{Authorization = "Basic {0}" -f $base64AuthInfo} -ContentType "application/json" -Method post -Body $body
