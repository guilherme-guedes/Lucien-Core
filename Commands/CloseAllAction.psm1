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
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUJ4j7xCCMaasMCr3xMPYVOfIo
# a6ugggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FPnrusye1ZwtR809epUX6rueg2e+MA0GCSqGSIb3DQEBAQUABIGAKFP6ja1IrmYu
# /iCdY4PvIBHtiUN1Oi3dZvR14sRaNN2tcRodMIqoiOAXGTDuqvTe9Rxpj5OaXqmo
# pCI66r3m+ijDvCE9HwGQXZWzBVoX+cMPWEaT0uUDzY+PjIfzgiKR9jPVVTJmXGso
# YeOg1VZazeKI9q9HK/nQyWPYdGcfu1Y=
# SIG # End signature block
