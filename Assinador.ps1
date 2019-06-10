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
	$assinador = [Assinador]::new()
	$certificado = Get-ChildItem cert:\CurrentUser\My -CodeSign | where Subject -Like "*PowerShell User*"
	$assinador.AssinarArquivos($certificado)
}

#start
Main(0)
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUpJ/XIvSeUpALUJA4UnnjnwDL
# 9AWgggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FGBe5ULbtpWA5waaKTp7cLLJOnDbMA0GCSqGSIb3DQEBAQUABIGAiwNPzr6uDkwE
# 7bT84UhKIbunrTCO/Ic3xXToaCIwMGY5RIPU6godKQz0787NxxSbPCPKrENcYI1Z
# SMUtD4aV/Ie1RW/BxWzEDwXIfj4DYMb9BxI2C/EXOhwZ90KxXKal93iKCdbMA3BK
# YAS/E0POhNLo2Xu8NuQygFnhzvslONs=
# SIG # End signature block
