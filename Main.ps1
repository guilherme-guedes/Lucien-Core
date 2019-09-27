using module .\Preditor.psm1

Param([parameter(Mandatory=$true, ValueFromPipeline=$true)][String[]]$actionWithParams)

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region Another Functions
function Exec($text){
	if($text)
	{
		$input = TratarTexto($text)

		# delimitador de parametros ':'
        if($text.Contains(':'))
        {
		    $parameters = $text.Substring($text.IndexOf(':')+1)
			$input = $input.Substring(0, $input.IndexOf(':'))
        }

		$preditor = [Preditor]::new()
		$action = $preditor.CruzarTextoPreditores($input)
		
		if($action) 
		{
			$returned = $action.Executar($parameters)
			
			if($returned)
			{
				return $returned
			}
			
			return $true
		}
	}		
	return $false
}

function TratarTexto($texto)
{
	if ($texto)
	{
		$texto = $texto.Replace(" o ", " ").Replace(" os ", " ").Replace(" a ", " ").Replace(" as ", " ").Replace(" um ", " ").Replace(" uns ", " ").Replace(" uma ", " ").Replace(" umas ", " ")
		$texto = $texto.ToLower()
			
		if ([String]::IsNullOrEmpty($texto.Trim()))
		{
			return $null
		}
	}
	return $texto
}

function TratarArgumentos($actionWithParams)
{
	Write-Host $actionWithParams
	return $actionWithParams
}
#endregion Functions


Exec(TratarArgumentos($actionWithParams)) > $null
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUrr3Zt6ihW2kOO3gG3HuqyDJl
# ifqgggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQU3HCKWuphxU8PlEJ3stCKjRmVNDcwDQYJKoZIhvcNAQEB
# BQAEggEAHgTlAUKtaKM/OXYkbQSa1fs5iseXkBUxrVKiMVAl4rv93OIDnnwUAHls
# NLpaHWBi3Gb2Wg0O4KZG2pzAM5gjaidjLwPJWF2+l3Feu0OHLIjHCFnvC9OQSwYW
# QzTQthaxZ2EsF5MeyDDHEnbLwso9/lU3sfOwYCo5no4AGzUMz6/uGFpnM/fpaD3D
# qh7T2eyf3BdUfOTI8pS4IWS0RTSpmwFe2jWul6I06yOZ2thI+NImwgwO9a+ZUbj5
# C7xUPnPL9Tb5LY3RhWOZXFijQ4bZmkAxgm6/0XrXwLzuSPLe8sUJAIh2ayD3wupv
# 0i6+uImEnEKvGsC+9TArQz+/eHQz5Q==
# SIG # End signature block
