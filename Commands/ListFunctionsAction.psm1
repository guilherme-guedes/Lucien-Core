using module .\LucienAbstractAction.psm1

class ListFunctionsAction : LucienAbstractAction
{

	[System.Collections.ArrayList] ObterTiposClasse($folder)
	{
		$retorno = New-Object System.Collections.ArrayList<String> 		
		$directory = New-Object System.IO.DirectoryInfo($PSScriptRoot + $folder)
		
		$files = $directory.GetFiles()	
		For ($i = 0; $i -lt $files.Length; $i++)
		{
			if(-not $files[$i].Name.Contains("Abstract") -and ($files[$i].Name.Contains(".ps1") -or $files[$i].Name.Contains(".psm1")) )
			{ 
				$className = ($files[$i].Name.Replace(".psm1","").Replace(".ps1",""))
						
				$retorno.Add($className)                
			}
		}
	
		return $retorno
	}
	
	[Void] Action($obj)
	{					
		$actions = $this.ObterTiposClasse('')		
        $textResponse = "Actions:" + [Environment]::NewLine
        For ($i = 0; $i -lt $actions.Count; $i++)
		{
			$textResponse += ([Environment]::NewLine + "-" + $actions[$i])                    
        }
        [System.Windows.Forms.MessageBox]::Show($textResponse.ToString())
	}
}
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUo+2KbcoUnL7LOymyiSe3Irtp
# ObqgggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUz+zqI+zgiowEI7Y3WaXWNU0jSGAwDQYJKoZIhvcNAQEB
# BQAEggEAov6BiCBsU5xF0qo/ukMfBHHbnugN+awQ1Lirqhl62ooZXspSkYeWkh7Z
# QG19XNPzX4U7P7rMUQjrfYIBwdPR0LuE9SI1OrWOJdxZPfKCoWv25vABUzhpOeqN
# wBoTYbzC6mbszUyqozfb2E9+3w14a2q05p5AmraaDGTFgP4lJg4npDSruavf9FhF
# TByZ6JZNwBYq66K5saZ18zbOZnxfxZFGz82y0b8nYeQDOqyufD4AZQ3sg2gpiD3/
# GqXqoxMtCcgzMqDh1YB+RTqOWwGZNorkqr6/B7mi4virEJuW6LkEfvFQSRcAO0pj
# GEws8rnhgZu+FbMLu5BjmvWGn3Cc+Q==
# SIG # End signature block
