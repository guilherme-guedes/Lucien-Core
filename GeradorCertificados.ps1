#makecert -n "CN=Lucien Local Certificate Root" -a sha1 -eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer -ss Root -sr localMachine
#makecert -pe -n "CN=Lucien User Certificate" -ss MY -a sha1 -eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer

$pwd = ConvertTo-SecureString "1234567" -AsPlainText -Force

$certRoot = New-SelfSignedCertificate -Subject "CN=Lucien Local Certificate Root" -FriendlyName "Lucien CR" -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign  -NotAfter (Get-Date).AddYears(20) -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2,1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.4,1.3.6.1.5.5.7.3.3,1.3.6.1.5.5.7.3.8,1.3.6.1.5.5.7.3.1","2.5.29.19={critical}{text}ca=TRUE") -KeyExportPolicy Exportable

# $directory = Get-Item -Path "c:/certs"
# if($null -eq $directory){
#     mkdir "c:/certs"
# }

$store = get-item Cert:\LocalMachine\Root
$store.Open("ReadWrite")
$store.Add($certRoot)
$store.Close()

# Import-Certificate -FilePath "c:/certs/LucienRootCA.cer" -Confirm -CertStoreLocation "Cert:\LocalMachine\Root" 
New-SelfSignedCertificate -Subject "CN=Lucien User Certificate" -FriendlyName "Lucien Certificate" -KeyUsage DigitalSignature -Type CodeSigningCert -CertStoreLocation "Cert:\CurrentUser\My" -Signer $certRoot -TextExtension @("2.5.29.37 = {Text} 1.3.6.1.5.5.7.3.3") -NotAfter (Get-Date).AddYears(20) -KeyExportPolicy Exportable


# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUS/I+9dMblGH3iJ/SeN/wXgs
# kCigggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUM+5E/mJRLEu8JueG3FbrrQKM3IEwDQYJKoZIhvcNAQEB
# BQAEggEAgrksGQmBYA9anVJyqdxyTrZJSXFL0ANjkMjJnP/nFJJp+iN5YMpi+CpX
# ZvvfP2YEEykNzIeIBP4yyPMRaMvO5e2nVZVhP/811bckr9eoanY9DSX+hJ4s5sXy
# W6qzxl65/ZcftZMZdZiX/01k1yaspn3NsEUC1QQZJO7k9T5F5a6Z4SDDc4GTU8IC
# FVbTGJA2iatxPkYn0SHhb6hl3gg269DH556ev7YnZRg7GEag1bibkuJpHKABJ69R
# sxcFjApzxPMPZU4FGMcxSr2/8Bkqgutlp/uUpQ4RpA11vuujJzix53i3tcwXYKDN
# Q5TzQdH9Z0VNSdGmnbf/GZFnZKj9Fw==
# SIG # End signature block
