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
# MIIEMwYJKoZIhvcNAQcCoIIEJDCCBCACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUIfis9H+kMiAfqayTmEEmjVmV
# o7ygggI9MIICOTCCAaagAwIBAgIQRB/Kygt5R6lMUNDyBxYGuTAJBgUrDgMCHQUA
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
# FIv7SD6C3s7NMu74sQ4/fk+lgEgSMA0GCSqGSIb3DQEBAQUABIGARIteKAb+sdII
# h2lmgSz0h8JpzxVrsD08oYpX0fr6Eee3oFJ/tytxU6YYpNZAh3+lYut95PkWPK9y
# I8SDc5RUUnz3jmk14UuAA+XY10claFZ0mUrGeV+czl9I1yXa5MVL7oOuO8d/zUIg
# 51RqeiFVGsqdna/5Xgbe8CZrFA6axso=
# SIG # End signature block
