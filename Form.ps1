using module .\Preditor.psm1

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
		
		[System.Windows.Forms.MessageBox]::Show("Não reconheço esta instrução! (" + $text + ")") > $null
	}
	else
	{	
		[System.Windows.Forms.MessageBox]::Show("Não recebi nenhuma instrução!") > $null
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
#endregion Functions

function BuildLucienApp($id)
{	
	$appContext = New-Object System.Windows.Forms.ApplicationContext
	$Form = New-Object system.Windows.Forms.Form
	
	$iconOK = $PSScriptRoot + '/lucien.ico'

	$Form.ClientSize                 = '393,110'
	$Form.text                       = "Lucien"
	$Form.TopMost                    = $false
	$Form.Location                   = New-Object System.Drawing.Point(0, 50)
	$Form.MaximizeBox                = $false
	$Form.MinimizeBox                = $false
	$Form.DataBindings.DefaultDataSourceUpdateMode = 0
	$Form.ShowInTaskbar            = $false
	#$Form.WindowState 				= "minimized"
	$Form.FormBorderStyle           = "FixedDialog"
	$Form.Icon                      = $iconOK
	$Form.KeyPreview 				= $true

	$lblLucien                       = New-Object system.Windows.Forms.Label
	$lblLucien.text                  = "Lucien"
	$lblLucien.AutoSize              = $true
	$lblLucien.width                 = 25
	$lblLucien.height                = 10
	$lblLucien.location              = New-Object System.Drawing.Point(160,5)
	$lblLucien.Font                  = 'Microsoft Sans Serif,13,style=Bold'
	$lblLucien.ForeColor             = "#4a4a4a"

	$tbxInput                        = New-Object system.Windows.Forms.TextBox
	$tbxInput.multiline              = $false
	$tbxInput.width                  = 384
	$tbxInput.height                 = 20
	$tbxInput.location               = New-Object System.Drawing.Point(5,83)
	$tbxInput.Font                   = 'Microsoft Sans Serif,10'

	$tbxResponse                     = New-Object system.Windows.Forms.TextBox
	$tbxResponse.multiline           = $true
	$tbxResponse.text                = "Deseja que eu execute alguma tarefa, sr?"
	$tbxResponse.BackColor           = "control"
	$tbxResponse.width               = 384
	$tbxResponse.height              = 45
	$tbxResponse.enabled             = $false
	$tbxResponse.location            = New-Object System.Drawing.Point(5,35)
	$tbxResponse.Font                = 'Microsoft Sans Serif,10'
	$tbxResponse.BorderStyle         = 'None'
	$tbxResponse.TextAlign 			 = 'Center'
	#$tbxResponse.ScrollBars 		 = 'Vertical'

	$Form.controls.AddRange(@($lblLucien,$tbxInput,$tbxResponse))

	$tbxInput.Add_KeyDown({
		if($_.KeyCode -eq "Enter") {
			# try
            # {			
                $resultadoExecucao = Exec($this.Text)
				$this.text = ""			
				if($resultadoExecucao)			
				{				
					Start-Sleep -Milliseconds 400
					$Form.Close() 
				}
            # }
            # catch [Exception]
            # {
              # #echo $_.Exception.GetType().FullName, $_.Exception.Message    
              # [System.Windows.Forms.MessageBox]::Show('Não consegui executar esta ação, sr.')   
            # }
		}
	})
	
	$Form.add_KeyDown({
		if($_.KeyCode -eq "Escape" ) {		
			$this.Close()	  
		}
	})
	
	$Form.add_Shown(
	{
		$workingArea = [System.Windows.Forms.Screen]::GetWorkingArea($this)
		$w = 950#[System.Drawing.Size]::Width
		$h = 550#[System.Drawing.Size]::Height
        $this.Location = New-Object System.Drawing.Point($w, $h)	
		$this.Activate()
	})
		
	$appContext.MainForm = $Form
	
	[void][System.Windows.Forms.Application]::Run($appContext)
}

function Main {
	BuildLucienApp(0)	
}

# start
Main(0)
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIfis9H+kMiAfqayTmEEmjVmV
# o7ygggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUi/tIPoLezs0y7vixDj9+T6WASBIwDQYJKoZIhvcNAQEB
# BQAEggEAeFOTaHXZasZ6jRT+twffNdeRKqRZbmos54MlSIn5bdkwDQkdSNzECiVF
# Sfo9gRiqgXKfPeEqX371mVzS/WGlPyfpYBF5kTajtDXgypKkyl8f47dk4oT0e1YY
# Kcmt8OlFoUjGSW716i3AVTbNJBjlm9PMCXQbqKGgBdLNAiRJXKzzQEyEf8njbO/q
# 45AdNBorKDuht/f5z6PXJ1pgpmXeqhqM8wKLFeY7A2DXBDO7vawPCr3G0CdebN54
# TzsjP6S5qgJ2dW236Qd/jZuuLms8/vUyvZe3Il4TFsdcHcTzm+XF29w4AdEyk4sE
# 9zUXwZrvrGP+l4DrCrL8/fYdZYmUDg==
# SIG # End signature block
