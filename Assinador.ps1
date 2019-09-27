# Assinador de scripts
# Auto-assina recursivamente os scripts a partir do diretório corrente com certificado informado
class Assinador
{
	[Void] AssinarArquivos($certificado)
	{
		$listaScripts = New-Object System.Collections.ArrayList<String> 
		$this.PreencherListaComScripts($PSScriptRoot, $listaScripts)
		
		For ($i = 0; $i -lt $listaScripts.Count; $i++)
		{
			$this.AssinarArquivo($listaScripts[$i], $certificado)
		}
	}

	[Void] AssinarArquivo($file, $certificado)
	{
		Set-AuthenticodeSignature $file $certificado
	}

	[Void] PreencherListaComScripts($entirePath, $lista)
	{		
		$directory = New-Object System.IO.DirectoryInfo($entirePath)
		
		$directories = $directory.GetDirectories()	
		if($directories)
		{
			For ($i = 0; $i -lt $directories.Length; $i++)
			{
				$this.PreencherListaComScripts($directories[$i].FullName, $lista)
			}
		}		
		
		$files = $directory.GetFiles()
		if($files)
		{
			For ($i = 0; $i -lt $files.Length; $i++)
			{
				if($files[$i].Name.Contains(".psm1") -or $files[$i].Name.Contains(".ps1"))
				{ 
					$lista.Add($files[$i].FullName)                
				}
			}
		}
	}
}

function Main {
	$certName =  "*Lucien User*"
	#"*Powershell User*"
	$assinador = [Assinador]::new()
	$certificado = Get-ChildItem cert:\CurrentUser\My | Where-Object Subject -like $certName
	
	$assinador.AssinarArquivos($certificado)
}

#start
Main(0)
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUABuCt2rghS705C0wsycRwcBP
# 4IGgggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUFuIBNxoQZbzwNcH8kffPFnBIclEwDQYJKoZIhvcNAQEB
# BQAEggEAnEcdj3+pR4e5hcfnm+vtH6+mZEZ8v8cAvJeM+7Lcysy9V6+vJflN19xR
# mGZJiZaM/yfzqcmoXWe09zItG+cesb83m+6/Q23j7M9INp2Pw+Cv61m/E2D9mU3x
# 4Msb61J86pg0Mtd/rjqdCgTDpn6HaxH4CtBCMPlFZc30S03enzx5O+uRc8QCcp/S
# U2Urq2sgKgXYVr8f9vlPTdOefS/6fhhT2nOPlPM9hC/DMDIpk8N1jEeR4AbiZyVt
# h3tqyZ4TUC/YvXqbt28BZ35HC3fuO13xdr7vpQnGPx1rEIu3F5U+XeMKtmMWCGia
# KOSNpXzhYIQkKd5K8F8j09lSkmGG4w==
# SIG # End signature block
