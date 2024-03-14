function Get-NestedValue {
    param (
        [Parameter(Mandatory = $true)]
        [Hashtable]$Object,
        
        [Parameter(Mandatory = $true)]
        [string]$Key
    )

    $keys = $Key -split '/'
    $current = $Object
    
    foreach ($k in $keys) {
        if ($current -is [System.Collections.Hashtable] -and $current.ContainsKey($k)) {
            $current = $current[$k]
        } else {
            return $null
        }
    }
    
    return $current
}

$object1 = @{
    "a" = @{
        "b" = @{
            "c" = "d"
        }
    }
}

$object2 = @{
    "x" = @{
        "y" = @{
            "z" = "a"
        }
    }
}

$value1 = Get-NestedValue -Object $object1 -Key "a/b/c"
$value2 = Get-NestedValue -Object $object2 -Key "x/y/z"

Write-Host "Value 1: $value1"
Write-Host "Value 2: $value2"
