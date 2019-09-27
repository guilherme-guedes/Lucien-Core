# Para novas actions adicionar a importação do modulo de expressões e action
using module .\Expressoes\AbstractExpressoesChave.psm1
using module .\Commands\LucienAbstractAction.psm1
using module .\Commands\QuitAction.psm1
using module .\Commands\TestaEzoopAction.psm1
using module .\Commands\ListFunctionsAction.psm1
using module .\Commands\OpenUrlAction.psm1
using module .\Commands\StartupAction.psm1
using module .\Commands\SaveOnEvernoteAction.psm1
using module .\Commands\CloseAllAction.psm1
using module .\Commands\ShowGenericWindowAction.psm1
using module .\Commands\DeployEzoopAction.psm1
using module .\Commands\ShowDietaAction.psm1
using module .\Commands\SlackMessageAction.psm1
using module .\Commands\GeradorTokenGymPassAction.psm1
using module .\Commands\AtualizaApisSpiceOnAction.psm1
using module .\Commands\StartCheckMatrizConnectionAction.psm1
using module .\Commands\StopCheckMatrizConnectionAction.psm1
using module .\Commands\GetIPSonicWallAction.psm1
using module .\Commands\DeploySpiceOnAction.psm1
using module .\Commands\SlackCleanerAction.psm1
using module .\Commands\ConnectCRMAction.psm1
using module .\Expressoes\QuitExpressoesChave.psm1
using module .\Expressoes\TestaEzoopExpressoesChave.psm1
using module .\Expressoes\ListFunctionsExpressoesChave.psm1
using module .\Expressoes\OpenUrlExpressoesChave.psm1
using module .\Expressoes\StartupExpressoesChave.psm1
using module .\Expressoes\SaveOnEvernoteExpressoesChave.psm1
using module .\Expressoes\CloseAllExpressoesChave.psm1
using module .\Expressoes\ShowGenericWindowExpressoesChave.psm1
using module .\Expressoes\DeployEzoopExpressoesChave.psm1
using module .\Expressoes\ShowDietaExpressoesChave.psm1
using module .\Expressoes\SlackMessageExpressoesChave.psm1
using module .\Expressoes\GeradorTokenGymPassChave.psm1
using module .\Expressoes\AtualizaApisSpiceOnExpressoesChave.psm1
using module .\Expressoes\StartCheckMatrizConnectionExpressoesChave.psm1
using module .\Expressoes\StopCheckMatrizConnectionExpressoesChave.psm1
using module .\Expressoes\GetIPSonicWallExpressoesChave.psm1
using module .\Expressoes\DeploySpiceOnExpressoesChave.psm1
using module .\Expressoes\SlackCleanerExpressoesChave.psm1
using module .\Expressoes\ConnectCRMExpressoesChave.psm1

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
	
	[System.Collections.ArrayList] ObterTiposClasse($folder)
	{
		$retorno = New-Object System.Collections.ArrayList<String> 		
		$directory = New-Object System.IO.DirectoryInfo($PSScriptRoot + $folder)
		
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
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUNmcgkU4dFkDQZKIXHnd0E3Gn
# DS6gggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
# AQsFADAoMSYwJAYDVQQDDB1MdWNpZW4gTG9jYWwgQ2VydGlmaWNhdGUgUm9vdDAe
# Fw0xOTA5MjcxNzAxMTRaFw0zOTA5MjcxNzExMTVaMCIxIDAeBgNVBAMMF0x1Y2ll
# biBVc2VyIENlcnRpZmljYXRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
# AQEA/bRcwnn3slVq3KXBXtA6NibrEXZmuh3Q2q2FqlLeF1wU9WUsp5ZPuUuYhYUr
# 8iRmlT5IMJ/qDPgGoVxtBoHHcFylXV8a6wzV7mnDqvq7yQXaPSBHm35StcGV4sH7
# Hf1L5xh+S633wLZtZzQhCPar/JoV5U1VW/cMWlBFjnlAAi+LLGYLaxgelLuGEJ/H
# xZqbnE4HmHXibpJQY18VaYKr9iB3r+bPrC02dcRwBav2mC1wF+1h+uIR4wYEkj2C
# LdVfKkBCDLQOheHYaZRjclZ+tpRWEDihV5jaXrYR+l+Hu4BAk09rglZo7q1fPsp2
# rEtd7cbwHf7Uu2P/kr2mj6bCxQIDAQABo2cwZTAOBgNVHQ8BAf8EBAMCB4AwEwYD
# VR0lBAwwCgYIKwYBBQUHAwMwHwYDVR0jBBgwFoAU5jjoZF20n16Ysi9x+FX7j0fh
# liMwHQYDVR0OBBYEFP6La6vfOXC7b7MvHWRs4C4hdJcxMA0GCSqGSIb3DQEBCwUA
# A4IBAQCb4NULSz04sBXpLeAysNGE+0zBZBgPJBI6vixH8og/P0M92fRH8GjpEU71
# yZkqH+FSvqgJmnOv81lK+ULJcweXMBdLmr8/hdSi5ucrEiMRJ3XjxH5bnla2tM+9
# i5p8RKEZvubOD45yqlL4rs8L+ceHwlFBXN+Op4i9+QvXnU2WiUy8CNk8OwYhSjWX
# qcHRgyhRFVwis0YAngCIXzLkxNjOgFM3HBLDa7AAxvcPTpuzYx3kurNAYvGbFiFq
# vouCKBFtKZWSSHtCB3h2ffF1jheuw7JkmTrEgqcT/wGsozdy995khEOApFnM339s
# IaGUNBxNlj1aEp7NSkJt7GBt8yWQMYIB3TCCAdkCAQEwPDAoMSYwJAYDVQQDDB1M
# dWNpZW4gTG9jYWwgQ2VydGlmaWNhdGUgUm9vdAIQJd8GuPlQ+L5F1zA5qgPYBTAJ
# BgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0B
# CQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAj
# BgkqhkiG9w0BCQQxFgQUw6UZEKKB+4AORZhu/FQMYjBEI4gwDQYJKoZIhvcNAQEB
# BQAEggEABlVqvQ9xl9RSNjtV++Q81Ve19KFjRQ09V0lTJ8DCuhfY4DJwZBNHVqzX
# W9lLNo2GZw8oKuKvXk8LT+h+I/f09yw+fFE9keNj6MJWSHeZ/mBHK3ay4rb0+qK9
# zfmmF520Fixm8nkym9krIlf39YUf4hbSujCbsGIH4zFnguTwphYGNwEMN0f3v8vr
# QPhvxdJcVmRzkYLnkOoniMCnj0FLfMwPGVsPqII5AfiJML9tdh9OsFmUM4jJqYQY
# XkYgwCPuWn3H+qmoRyPxcE5ZWneQzjEsL51x2So1Bw51z7XxRlH/u4Eu3e2DTn1x
# uZOz7jQC0kZzWsdszJBhkdKlC1VDWw==
# SIG # End signature block
