using module .\LucienAbstractAction.psm1

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# Set the ConfiguracoesFTP methods to custom your deploy via FTP

class DeployAction : LucienAbstractAction
{
	[Void] Action($obj)
	{	
		msbuild "C:\project-foler\MyProject.sln" /p:DeployOnBuild=true /p:PublishProfile=Properties\PublishProfiles\Custom.pubxml
			
		$configs = New-Object ConfiguracoesFTP	
		$deployer = New-Object Deployer		

		$dirOrigin = $configs.GetBaseFolderOrigin()
		$user =  $configs.GetUser()
		$pass = $configs.GetPass()
		$ftpServer = $configs.GetFTP()	
		$dir = $configs.GetBaseURLDestiny()
		$uriDestiny = $ftpServer + $dir + '_nova/'

		$deployer.UploadFilesActive($uriDestiny, $user, $pass, $dirOrigin)	
		$deployer.Update($ftpServer + $dir, $user, $pass, $dir)
	}

	[Void] UploadFilesActive($ftp_uri, $user, $pass, $path)
	{	
		foreach($item in Get-ChildItem -recurse $path)
		{
			$relpath = [system.io.path]::GetFullPath($item.FullName).SubString([system.io.path]::GetFullPath($path).Length + 1)
			if ($item.Attributes -eq "Directory")
			{
				try
				{
					$aux = $ftp_uri + $relpath
					Write-Host $aux
					$makeDirectory = [System.Net.WebRequest]::Create($aux)
					$makeDirectory.UsePassive = $false
					$makeDirectory.UseBinary = $true
					$makeDirectory.KeepAlive = $true
					$makeDirectory.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
					$makeDirectory.Method = [System.Net.WebRequestMethods+FTP]::MakeDirectory
					$makeDirectory.GetResponse() > $null
				}
				catch [Net.WebException]
				{
					Write-Host " " $item.Name Directory may be already exists.
				}
				continue;
			}			
			
			$uri = $ftp_uri + $relpath	
			$ftp = [System.Net.FtpWebRequest]::Create($uri)
			$ftp = [System.Net.FtpWebRequest]$ftp
			$ftp.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
			$ftp.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
			$ftp.UseBinary = $true
			$ftp.UsePassive = $true
			$ftp.KeepAlive = $true
			$content = [System.IO.File]::ReadAllBytes($item.FullName)
			$ftp.ContentLength = $content.Length
			$rs = $ftp.GetRequestStream()
			$rs.Write($content, 0, $content.Length)
			$rs.Close()
			$rs.Dispose()
		}
	}	

	[Void] Update($uri, $user, $pass, $dir)
	{
		$credentials = New-Object System.Net.NetworkCredential($user, $pass)
		$ftpOperations = New-Object FTPOperations
		
		# criação e rename de pastas (_bkp)			
		Write-Host Criando e renomeando pastas de $uri...
		$ftpOperations.RenameBkpFolderToOld($uri, $user, $pass)		
		$ftpOperations.CreateBkpFolder($uri, $user, $pass)			
		
		# virada de chave (_nova)				
		Write-Host Movendo conteudo da raiz para _bkp...
		$files = $ftpOperations.GetFileList($uri, $credentials)
		$ftpOperations.MoveFilesToBkp($uri, $user, $pass, $files)			
		
		Write-Host Movendo conteudo de _nova para $dir...
		$files = $ftpOperations.GetFileList($uri + "_nova/", $credentials)
		$ftpOperations.MoveFilesToRoot($uri, $user, $pass, $files)	
		Start-Sleep	-Milliseconds 100
		
		[System.Windows.Forms.MessageBox]::Show("Manipulacao de arquivos (Virada de chave) concluida!") > $null		
		
		Write-Host Removendo diretorios _bkp.old...
		$ftpOperations.DeleteDirectory($uri + "_bkp.old/", $credentials)		
	}
}

class FTPOperations
{
	[Void] MoveTo($uriRoot, $user, $pass, $file, $uriFolder, $uriNewFolder)
	{
		try
		{		
			$uriFrom = $uriRoot+$uriFolder+$file 
			$uriTo = $uriNewFolder+$file
			
			$ftp =  [System.Net.WebRequest]::Create($uriFrom)			
			$ftp.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
			$ftp.UsePassive = $true
			$ftp.KeepAlive = $false
			$ftp.Method = [System.Net.WebRequestMethods+Ftp]::Rename   
			$ftp.RenameTo = $uriTo
			$ftp.GetResponse().Close()
		}
		catch
		{
			write-host ""
			Write-Host $_.Exception.Message
			Write-Host ERROR: erro ao mover para $uriNewFolder
		}
	}

	[Void] RenameBkpFolderToOld($ftp_uri, $user, $pass)
	{
		try
		{
			$ftp =  [System.Net.WebRequest]::Create($ftp_uri + "_bkp")			
			$ftp.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
			$ftp.UsePassive = $true
			$ftp.Method = [System.Net.WebRequestMethods+Ftp]::Rename   
			$ftp.RenameTo = "_bkp.old"
			$ftp.GetResponse() > $null	
			Write-Host pasta _bkp renomeada para _bkp.old
		}
		catch [Net.WebException]
		{
			write-host ""
			Write-Host ERROR: erro ao renomerar _bkp para _bkp.old
		}
	}
		
	[Void] CreateBkpFolder($ftp_uri, $user, $pass)
	{
		try
		{
			$ftp = [System.Net.WebRequest]::Create($ftp_uri + "_bkp")
			$ftp.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
			$ftp.UsePassive = $true
			$ftp.KeepAlive = $false
			$ftp.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory   
			$ftp.UseBinary = $true
			$ftp.GetResponse() > $null	
			Write-Host pasta _bkp criada
		}
		catch [Net.WebException]
		{
			write-host ""
			Write-Host ERROR: erro ao criar _bkp
		}
	}

	[Void] MoveFilesToBkp($uriRoot, $user, $pass, $files)
	{
		if($files -and $files.Count -gt 0)
		{
			for($i=0; $i -lt $files.Count; $i++)
			{
				$this.MoveTo($uriRoot, $user, $pass, $files[$i], "", "./_bkp/")
			}
		}
	}

	[Void] MoveFilesToRoot($uriRoot, $user, $pass, $files)
	{
		if($files -and $files.Count -gt 0)
		{
			for($i=0; $i -lt $files.Count; $i++)
			{
				$this.MoveTo($uriRoot, $user, $pass, $files[$i], "_nova/", "./../")
			}
		}
	}

	[Void] DeleteDirectory($uriDir, $credentials)
	{			
		$files = $this.GetDirectoryDetails($uriDir, $credentials)
		
		if($null -eq $files -and $files.Length -le 0)
		{
			return
		}
		
		foreach ($file in $files)
		{
			$fileUrl = ""
			$tokens = $file.Split(" ", 9, [StringSplitOptions]::RemoveEmptyEntries)				
			$diretorio = $false
			
			if($tokens -and $tokens.Length -gt 4)
			{				
				$name = $tokens[8]
				$permissions = $tokens[0]	
				$fileUrl = ($uriDir + $name)
			
				if ($permissions[0] -eq 'd')
				{
					$diretorio = $true
				}			
			}
			else
			{
				$name = $tokens[3]	
				$fileUrl = ($uriDir + $name)
				for($i=0; $i -lt $tokens.Length; $i++)
				{
					if(([String]$tokens[$i]).ToLower() -contains "<dir>")
					{
						$diretorio = $true
					}
				}					
			}
			
			if ($diretorio)
			{
				$this.DeleteDirectory($fileUrl + "/", $credentials)
			}
			else
			{
				$this.DeleteFile($fileUrl, $credentials)
			}
		}
		
		try
		{
			write-host ""
			Write-Host "Removendo diretorio: $uriDir"				
			$deleteRequest = [Net.WebRequest]::Create($uriDir.TrimEnd('/'))
			$deleteRequest.Credentials = $credentials
			$deleteRequest.Method = [System.Net.WebRequestMethods+Ftp]::RemoveDirectory
			$deleteRequest.GetResponse() | Out-Null
		}
		catch
		{
			write-host ""
			write-host EROR: erro ao tentar remover diretorio! $_.Exception.Message
		}
	}

	[System.Collections.ArrayList] GetFileList($uri, $credentials)
	{
		$files = New-Object System.Collections.ArrayList
		try 
		{
			$FTPRequest = [System.Net.FtpWebRequest]::Create($uri)		
			$FTPRequest.Credentials = $credentials
			$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory 						
			$FTPResponse = $FTPRequest.GetResponse() 
			$ResponseStream = $FTPResponse.GetResponseStream()
			$StreamReader = New-Object System.IO.StreamReader $ResponseStream  
			While ($file = $StreamReader.ReadLine())
			{
				if(-not $file.StartsWith("_") -and $file)
				{
					$files.add($file) > $null
				}
			}
			
			$StreamReader.close()
			$ResponseStream.close()
			$FTPResponse.Close()
		}
		catch 
		{
			write-host ""
			write-host ERROR: $_.Exception.Message
		}

		return $files
	}

	[System.Collections.ArrayList] GetDirectoryDetails($uri, $credentials)
	{
		$files = New-Object System.Collections.ArrayList
		try 
		{
			$FTPRequest = [System.Net.FtpWebRequest]::Create($uri)		
			$FTPRequest.Credentials = $credentials
			$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails 						
			$FTPResponse = $FTPRequest.GetResponse() 
			$ResponseStream = $FTPResponse.GetResponseStream()
			$StreamReader = New-Object System.IO.StreamReader $ResponseStream  
			While ($file = $StreamReader.ReadLine())
			{
				$files.add($file) > $null
			}
			
			$StreamReader.close()
			$ResponseStream.close()
			$FTPResponse.Close()
		}
		catch 
		{
			write-host " "
			write-host ERRO: $_.Exception.Message
		}

		return $files
	}

	# não apagará com espaços
	[Void] DeleteFile($uriFile, $credentials)
	{
		try 
		{
			Write-Host "Removendo arquivo: $uriFile"
			$FTPRequest = [System.Net.FtpWebRequest]::Create($uriFile)		
			$FTPRequest.Credentials = $credentials
			$FTPRequest.Method = [System.Net.WebRequestMethods+Ftp]::DeleteFile
			$FTPRequest.GetResponse() | Out-Null
		}
		catch 
		{
			write-host ""
			write-host ERROR: erro ao tentar remover arquivo! $_.Exception.Message
		}
	}
}

class ConfiguracoesFTP
{
	[String] GetFTP()
	{
		return "ftp://"
	}

	[String] GetUser()
	{
		return "user"
	}

	[String] GetPass()
	{
		return "pass"
	}				

	[String] GetBaseURLDestiny()
	{
		return "base-folder/"
	}
	
	[String] GetBaseFolderOrigin()
	{
		return "C:/intepub/wwwrot/base-folder"
	}
}
	
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU64JTXo7sU1WV9rU/KVR5nwNf
# ccWgggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FO2wgtEubfU9xih6uW24/I593l5yMA0GCSqGSIb3DQEBAQUABIGAFm8cecF6WE2k
# FCdPnjCwxE3H1K1mXID01bDgBI6wDBw72KobEKC6/Ee/cy+UABVGV4/ylGA0X/nQ
# 4p2XhfSK2zVRaHOWx5lHQeESUT0wwZrykD3TMpS2BqTIHxu7WddWDMYeJyuFC0N7
# f1Jaalt7NLJGuUNyhyFketCeRqcKLo4=
# SIG # End signature block
