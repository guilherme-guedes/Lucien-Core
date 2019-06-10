using module .\LucienAbstractAction.psm1

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

# parametros 
# text: texto livre a ser exibido na janela
class ShowGenericWindowAction : LucienAbstractAction
{
	[Void] Action($obj)
	{
		$this.ShowForm($obj)
	}
	
	[Void] ShowForm($text)
	{
		$GenericForm = New-Object system.Windows.Forms.Form	
		$iconOK = $PSScriptRoot + '/lucien.ico'
				
		$GenericForm.ClientSize                 = '394,110'
		$GenericForm.text                       = "Lucien"
		$GenericForm.TopMost                    = $false
		$GenericForm.MaximizeBox                = $false
		$GenericForm.MinimizeBox                = $false
		$GenericForm.DataBindings.DefaultDataSourceUpdateMode = 0
		$GenericForm.ShowInTaskbar              = $false
		$GenericForm.FormBorderStyle            = "FixedDialog"
		$GenericForm.Icon                       = $iconOK
		$GenericForm.KeyPreview 			    = $true
		$GenericForm.BackColor          		= "#e9f3f5"
		$GenericForm.startposition = "centerscreen"

		$lblLucienGF                       = New-Object system.Windows.Forms.Label
		$lblLucienGF.text                  = "Atencao!"
		$lblLucienGF.AutoSize              = $true
		$lblLucienGF.width                 = 25
		$lblLucienGF.height                = 10
		$lblLucienGF.Location              = New-Object System.Drawing.Point(170,5) #197 - 2m - 25w
		$lblLucienGF.Font                  = 'Microsoft Sans Serif,12,style=Bold'
		$lblLucienGF.ForeColor             = "#4a4a4a"

		$tbxTextoGF                        = New-Object system.Windows.Forms.TextBox
		$tbxTextoGF.AutoSize               = $true
		$tbxTextoGF.width                  = 390
		$tbxTextoGF.height                 = 20
		$tbxTextoGF.location               = New-Object System.Drawing.Point(2,45)
		$tbxTextoGF.Font                   = 'Microsoft Sans Serif,12'
		$tbxTextoGF.ForeColor              = "#4a4a4a"
		$tbxTextoGF.text			 	   = $text
		$tbxTextoGF.multiline              = $true
		$tbxTextoGF.BorderStyle            = "none"		
		$tbxTextoGF.BackColor            = "#e9f3f5"
		$tbxTextoGF.enabled              = $false	
		$tbxTextoGF.TextAlign 			 = "Center"
		
		$GenericForm.controls.AddRange(@($lblLucienGF,$tbxTextoGF))
		
		$GenericForm.add_KeyDown({
			if($_.KeyCode -eq "Escape" ) {		
				$this.Close()	  
			}
		})
		
		$GenericForm.Add_Shown({$this.Activate()})
		$GenericForm.ShowDialog()
	}
}
# SIG # Begin signature block
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU31x7Vmr0VicDGVUcnomjVjua
# fpegggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FKcdwiISzfECiKyvqHQY7/SjPxqQMA0GCSqGSIb3DQEBAQUABIGAW3KTIqhToZia
# OxpvuXsJXJpJjWogovNRIhlpsYcfiu7Plrl5J0BhfIN30BgXTAr7f2/0+ANHpwKc
# DCYcEo0jvHOIJnATSUv0d44k0c6CPpbcplkMYSi4kXuo8B/xaLyTZFXjS+9ZawOd
# h6ocBHvX7KDEa1KsPw9swKPIs5pRaFQ=
# SIG # End signature block
