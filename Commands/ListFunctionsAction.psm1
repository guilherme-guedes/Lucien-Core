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
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUo+2KbcoUnL7LOymyiSe3Irtp
# ObqgggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FM/s6iPs4IqMBCO2N1ml1jVNI0hgMA0GCSqGSIb3DQEBAQUABIGAS7rNB1nZyRol
# L4HXyXhXjoGjg4s2wsxsu8r+W8/ZshgpJKjR2pjThOTh+UCLd3sP23HSZhHkyacZ
# DNIX26qc72k53paBAYyMV4d4KqjLOJLXmgtwB0hv3C32aGfGT8z4h+ATlnky8J9P
# T9z/XtqDwUFzU1CBZo9sbqDrHyz0OdA=
# SIG # End signature block
