using module .\AbstractExpressoesChave.psm1
using module ..\Commands\LucienAbstractAction.psm1
using module ..\Commands\GetIPSonicWallAction.psm1

class GetIPSonicWallExpressoesChave : AbstractExpressoesChave
{
    GetIPSonicWallExpressoesChave ()
    {
		$this.ExpressoesChave =  "get ip vpn", "get vpn ip", "get ip vpn", "get sonicwall ip", "ip vpn", "vpn ip", "sonicwall ip", "get sw ip"
    }

	[LucienAbstractAction] Action()
    {
        return [GetIPSonicWallAction]::new()
    }
}
# SIG # Begin signature block
# MIIFsgYJKoZIhvcNAQcCoIIFozCCBZ8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUERQ1sXC2kTdK3H/keP6930fO
# sPugggM/MIIDOzCCAiOgAwIBAgIQJd8GuPlQ+L5F1zA5qgPYBTANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUXFu7d2gK3xkh4ctdN0+HGqBoT9UwDQYJKoZIhvcNAQEB
# BQAEggEA4n1Ebgtopb2uDyUiLBylBLI3KOzLnikz/+TgSHPN90tvf//XKQYXTWuw
# DI6OfwLDef44vbLP3EIY/5qFqPZyOL8Q48Rlx9nNI/fcR6S2ChBXzTJD3cdGUf+u
# d/CsIPXGY3wDmlitGINa3o2gmEnpxw0cTnEhlvgPd5Du7gDP6yps/8jQaXarVJ7K
# pS0XvACDfDYTHPIixpc81e2yxzosr7qmultYfPF8YnindI4hBKQQTSUmi0v342ah
# XEM7dXZhQ2kh5EkoAKPpAWNuqH/x2+MgHpTT2fPeI0b7erGE/pLAFC4CB9VlBS9B
# T3WzAYJqVpeJ2xDGQCFGZoekJGqTVQ==
# SIG # End signature block
