param ([string]$keyvaultName, [string]$secretName, [string]$secretValue)

$existingSecret = Get-AzKeyVaultSecret -VaultName $keyvaultName -Name $secretName
$secureSecretValue = ConvertTo-SecureString -String $secretValue -AsPlainText -Force

if($null -ne $existingSecret){
    if($existingSecret.SecretValueText -eq $secretValue){
        Write-Host "Secret is already present. Skipping processing.."
    }
    else{
        Set-AzKeyVaultSecret -VaultName $keyvaultName -Name $secretName -SecretValue $secureSecretValue
        Write-Host "Updated Secret in Key Vault"
    }
}
else{
    Set-AzKeyVaultSecret -VaultName $keyvaultName -Name $secretName -SecretValue $secureSecretValue
    Write-Host "Created Secret in Key Vault"
}