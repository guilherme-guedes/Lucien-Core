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
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU31x7Vmr0VicDGVUcnomjVjua
# fpegggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUpx3CIhLN8QKIrK+odBjv9KM/GpAwDQYJKoZIhvcNAQEB
# BQAEggEA8PTrgzf1nSdKdxl0VQnX2afWkxRB4ikfQHqo1BS7+LBkq/gYp/sQCSe7
# mW6aHhiSMHafKwDj6iMB3OVfVNKry4Sw3cIAGBcTplGXw8qQiOryv5syD9OY5K9Y
# 8CBFazyPbLUgu4RmRB2FeuPcvuFMBL5/ExH1kJOL9B5EARHHM5HGHp846bkG55nI
# Nkc1+WeeiN7wdpLj/A8nzJNN4hAF5USxgzM3qIze913Iy04JgJ4EA9KU61B5u4Vq
# KePlOZyYm5foGTDPyk5g6qu1vVTsdDPW/7b00yP9P6GC1Bu5JLhvEzBdlxldythk
# eZNjS2lwyRF/ptezl5X2dP7Wm0tqzw==
# SIG # End signature block
