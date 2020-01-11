
$region='eastus'

$networkRgDeploy = New-AzDeployment -Location $region -TemplateFile .\iac\resourceGroupTemplate.json -TemplateParameterObject @{
    rgName = "network"
    rgLocation = $region
    environment = "demo"
}
$vnetDeploy = New-AzResourceGroupDeployment -ResourceGroupName $networkRgDeploy.Outputs['rgFullName'].Value -TemplateFile .\iac\VNET.json -TemplateParameterFile .\iac\VNET.parameters.json

$storageRgDeploy = New-AzDeployment -Location $region -TemplateFile .\iac\resourceGroupTemplate.json -TemplateParameterObject @{
    rgName = "storage"
    rgLocation = $region
    environment = "demo"
}
$storageDeploy = New-AzResourceGroupDeployment -ResourceGroupName $storageRgDeploy.Outputs['rgFullName'].Value -TemplateFile .\iac\sa.json -TemplateParameterFile .\iac\sa.parameters.json

$securityRgDeploy = New-AzDeployment -Location $region -TemplateFile .\iac\resourceGroupTemplate.json -TemplateParameterObject @{
    rgName = "security"
    rgLocation = $region
    environment = "demo"
}
$keyVaultDeploy = New-AzResourceGroupDeployment -ResourceGroupName $securityRgDeploy.Outputs['rgFullName'].Value -TemplateFile .\iac\KeyVault.json -TemplateParameterFile .\iac\KeyVault.parameters.json

$rigRgDeploy = New-AzDeployment -Location $region -TemplateFile .\iac\resourceGroupTemplate.json -TemplateParameterObject @{
    rgName = "vdi-video"
    rgLocation = $region
    environment = "demo"
}

$rigDeploy = New-AzResourceGroupDeployment -ResourceGroupName $rigRgDeploy.Outputs['rgFullName'].Value -TemplateFile .\iac\GamingRig.json -TemplateParameterFile .\iac\GamingRig.parameters.json
