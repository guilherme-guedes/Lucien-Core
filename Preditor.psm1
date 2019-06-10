# Para novas actions adicionar a importação do modulo de expressões e action
using module .\Expressoes\AbstractExpressoesChave.psm1
using module .\Commands\LucienAbstractAction.psm1
using module .\Commands\ListFunctionsAction.psm1
using module .\Commands\OpenUrlAction.psm1
using module .\Commands\StartupAction.psm1
using module .\Commands\SaveOnEvernoteAction.psm1
using module .\Commands\CloseAllAction.psm1
using module .\Commands\ShowGenericWindowAction.psm1
using module .\Commands\SlackMessageAction.psm1
using module .\Expressoes\ListFunctionsExpressoesChave.psm1
using module .\Expressoes\OpenUrlExpressoesChave.psm1
using module .\Expressoes\StartupExpressoesChave.psm1
using module .\Expressoes\SaveOnEvernoteExpressoesChave.psm1
using module .\Expressoes\CloseAllExpressoesChave.psm1
using module .\Expressoes\ShowGenericWindowExpressoesChave.psm1
using module .\Expressoes\SlackMessageExpressoesChave.psm1

class Preditor{

	[LucienAbstractAction] CruzarTextoPreditores($texto)
	{
		$actions = $null
		if (-not [String]::IsNullOrEmpty($texto))
		{
			$actions = New-Object LucienAbstractAction
			
			$tipos = $this.ObterTiposClasse("/Expressoes")
			if ($tipos -and $tipos.Count -gt 0)
			{
				For ($i = 0; $i -lt $tipos.Count; $i++)
				{
					$t = $tipos[$i]
					$objExpressoes = $this.instanceExpression($t)
					$expressoesChave = $objExpressoes.ExpressoesChave

					if ($this.CruzaExpressoesChave($texto, $expressoesChave))
					{
						$action = $objExpressoes.Action()
						return $action
					}
				}
			}
		}
		return $null
	}

    [AbstractExpressoesChave] instanceExpression([String] $Type)
    {
        return (New-Object -TypeName "$Type")
    }
	
	[System.Collections.ArrayList] ObterTiposClasse($folders)
	{
		#implementar multiplas pastas folder = folders
	
		$retorno = New-Object System.Collections.ArrayList<String> 		
		$directory = New-Object System.IO.DirectoryInfo($PSScriptRoot + $folders)
		
		$files = $directory.GetFiles()	
		For ($i = 0; $i -lt $files.Length; $i++)
		{
			if(-not $files[$i].Name.Contains("Abstract") -and -not $files[$i].Name.Contains(".bat"))
			{ 
				$className = ($files[$i].Name.Replace(".psm1","").Replace(".ps1",""))
						
				$retorno.Add($className)                
			}
		}
	
		return $retorno
	}
	
	[Bool] CruzaExpressoesChave($texto, $expressoesChave)
	{
		$referenceRegex = [String]::Join('|', $expressoesChave)
		
		$retorno = $false
		if ($texto -match $referenceRegex)
		{
			$retorno = $true
		}
			
		return $retorno
	}
	
	#region Another methods
	
	# carregamento de modulos dinamico - revisar depois
	[Void] importModules()
	{	
		# actions modules to import
		$pathFolder = $PSScriptRoot + '/Commands/'
		$modulesToImport  = $this.ObterTiposClasse("/Commands")

		foreach($import in $modulesToImport)
		{
			if (Get-Module -ListAvailable -Name $import) 
			{
			}
			else 
			{
				$moduleImp = $pathFolder + $import
				Import-Module $moduleImp -Force -Global -Verbose
			}
		}
	
		# expressoes modules to import
		$pathFolder = $PSScriptRoot + '/Expressoes/'
		$modulesToImport  = $this.ObterTiposClasse("/Expressoes")

		foreach($import in $modulesToImport)
		{
			if (Get-Module -ListAvailable -Name $import) 
			{
			}
			else 
			{
				$moduleImp = $pathFolder + $import
				Import-Module $moduleImp -Force -Global -Verbose
			}
		}		
		Start-Sleep -s 2
	}
	
	#endregion
}
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUDhOvFQODCAl/VmT67Ku667/u
# MzagggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
# MCwxKjAoBgNVBAMTIVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0xODA3MTExMzQ3MDdaFw0zOTEyMzEyMzU5NTlaMBoxGDAWBgNVBAMTD1Bvd2Vy
# U2hlbGwgVXNlcjCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA7D/xKdyakjTJ
# PaF6vFcVorNLkQziZWqdVSzuHSV0+mV2IFNIXWh+2nRBHXxEM6nzgrXurPfTfjTN
# F1hbzIv45ePY9yku5qItz++ORBhEjD0eK0oul55KQ2PCyjg/ivTndueyNiF3/Yq5
# MFezuB4JizU/yHY9P7nrPh9ZVGWAGJECAwEAAaN2MHQwEwYDVR0lBAwwCgYIKwYB
# BQUHAwMwXQYDVR0BBFYwVIAQ9d6IouSOM/0qPyfJRpkQz6EuMCwxKjAoBgNVBAMT
# IVBvd2VyU2hlbGwgTG9jYWwgQ2VydGlmaWNhdGUgUm9vdIIQ6Cu+6PTfwJlNzluZ
# 5OEx4jAJBgUrDgMCHQUAA4GBAB6jjoZ6cUVyiT7HlAcihtd3a09i3SHRVkHtP6Xo
# Ottw7r8wNcIpc+EKpSwmy2Sg3UehDGNwo2Rikebc3D+/0DrbPN49m1AhhsqQ3wM4
# +kfuJlXxktCiocGpDq9nzF395DsZHvHj5PUmXvrajWNK3igNEy9v0XjV1xbjUCPv
# vgqeMYIBYDCCAVwCAQEwQDAsMSowKAYDVQQDEyFQb3dlclNoZWxsIExvY2FsIENl
# cnRpZmljYXRlIFJvb3QCEEQfysoLeUepTFDQ8gcWBrkwCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FHYPs2hMwHg59KEHYijDm0dMFPzVMA0GCSqGSIb3DQEBAQUABIGANz+i+q0isDJV
# IjLCNewxF1+M1MrPNkzticr02dYcp9G6xqRzhXTe+yXatFTGmIQOGGJnGm7iUCM3
# 5NnFUqzOqoRNt17SpzR8tLymRy5sNfQcyqidGh7tSMLIq8XQVuFf9vCqYp10W8cx
# Ns54zTFiZT3lY437MqbrvYZTt+ZCMYs=
# SIG # End signature block
