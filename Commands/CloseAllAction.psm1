using module .\LucienAbstractAction.psm1

# Put all proccess to close 'Stop-Process -Name "{proccess-name}" -Force'

# parametros 
# shutdown:
#   s | shutdown - (desligar)
#   r | reboot - (reiniciar)
class CloseAllAction : LucienAbstractAction
{
	[String[]] $processos
		
	CloseAllAction()
	{
		$this.processos = @("pgadmin3", 
		,"Franz"
		,"chrome"
		,"notepad"
		,"notepad++"
		,"EvernoteClipper"
		,"SWGVC" #VPN
		,"SWGVCSvc" #VPN
		,"xampp-control"
		,"Spark"
		,"filezilla"
		)
	}
		
	[Void] Action($obj)
	{
		try
		{
			if($this.processos)
			{
				For($i = 0; $i -lt $this.processos.Length; $i++)
				{
					try
					{
						Stop-Process -Name $this.processos[$i] -Force
						Start-Sleep -Milliseconds 80
					}
					catch [Exception]
					{
					}
				}
			}
			#devenv  - Visual Studio
			#explorer - Windows Explorer
			Start-Sleep -Milliseconds 120
			Stop-Process -Name "devenv" -Force
			Start-Sleep -Milliseconds 200
			Stop-Process -Name "explorer" -Force
			Start-Sleep -Milliseconds 100
		}
		catch [Exception]
		{
		}
		finally
		{
			Write-Host Parametros: $obj
			if($obj)
			{
				if($obj.ToLower().Contains("s") -or $obj.ToLower().Contains("shutdown"))
				{	
					Stop-Computer -Force
				}
				elseif($obj.ToLower().Contains("r") -or $obj.ToLower().Contains("reboot"))
				{					
					Restart-Computer -Force
				}			
			}		
		}
	}	
}
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUJ4j7xCCMaasMCr3xMPYVOfIo
# a6ugggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQU+eu6zJ7VnC1HzT16lRfqu56DZ74wDQYJKoZIhvcNAQEB
# BQAEggEAd3u++xM9wQ5ahYpxEW+kbYjiOhk6FhmcmCj1O+LfOkFHabCf4gpTYOZc
# ecKxGPRQhaVCDVt0mOFfI2Wzwjn3jl9ue2kQAIgehazJyJPK5lWBYtKFJO24j7aN
# tGUhOkEm32pM76XXkQ7WOYIp0Mn+WNrW2B/+/x2OK+M22Zmar054/NhtIvYIZD5f
# xBCmL7ThP0RhG8rHpoNQ7Hqa1BC1c7X22XK+aiI2LPGG/MME4a4hTsVIl4MKuMUv
# 4BfUkdbomEtrQjZNLClL3EnAZ7P/5HK1JPy4L/WMi9o9qpMO5Pf8+fMGSo40Vs7X
# cpEWxFqXBv7yF1te5tQjaZF/jekt2g==
# SIG # End signature block
