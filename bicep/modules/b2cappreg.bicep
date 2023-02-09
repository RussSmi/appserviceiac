@description('Required. Display name of the script to be run.')
param name string

@description('Optional. The ID(s) to assign to the resource.')
param userAssignedIdentities object = {}

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Type of the script. AzurePowerShell, AzureCLI.')
@allowed([
  'AzurePowerShell'
  'AzureCLI'
])
param kind string = 'AzureCLI'

@description('Optional. Azure PowerShell module version to be used.')
param azPowerShellVersion string = '3.0'

@description('Optional. Azure CLI module version to be used.')
param azCliVersion string = ''

@description('Optional. Script body. Max length: 32000 characters. To run an external script, use primaryScriptURI instead.')
param scriptContent string = ''

@description('Optional. Use the script file included in the project')
param useScriptFile bool = true

@description('Optional. Uri for the external script. This is the entry point for the external script. To run an internal script, use the scriptContent instead.')
param primaryScriptUri string = ''

@description('Optional. List of supporting files for the external script (defined in primaryScriptUri). Does not work with internal scripts (code defined in scriptContent).')
param supportingScriptUris array = []

@description('Optional. Command-line arguments to pass to the script. Arguments are separated by spaces.')
param arguments string = ''

@description('Optional. Interval for which the service retains the script resource after it reaches a terminal state. Resource will be deleted when this duration expires. Duration is based on ISO 8601 pattern (for example P7D means one week).')
param retentionInterval string = 'P1D'

@description('Optional. When set to false, script will run every time the template is deployed. When set to true, the script will only run once.')
param runOnce bool = false

@description('Optional. The clean up preference when the script execution gets in a terminal state. Specify the preference on when to delete the deployment script resources. The default value is Always, which means the deployment script resources are deleted despite the terminal state (Succeeded, Failed, canceled).')
@allowed([
  'Always'
  'OnSuccess'
  'OnExpiration'
])
param cleanupPreference string = 'Always'

@description('Optional. Maximum allowed script execution time specified in ISO 8601 format. Default value is PT1H - 1 hour; \'PT30M\' - 30 minutes; \'P5D\' - 5 days; \'P1Y\' 1 year.')
param timeout string = 'PT1H'

var scriptString = useScriptFile == true ?  loadTextContent('../scripts/b2cappreg.sh') : null

@description('The B2C Tenant Id')
param b2cTenantId string

@description('The B2C Service Principal App Id')
param b2cSpAppId string

@description('The B2C Service Principal Secret')
param b2cSpSecret string


