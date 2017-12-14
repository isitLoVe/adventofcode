$in = Get-Content -Path "in\day8.txt"
#$in = Get-Content -Path "in\day8test.txt"

#7981 too high

$register = @{}
$cont = $false
$p2 = 0

$DebugPreference = "SilentlyContinue"


foreach ($line in $in) {

    $var1,$instruction,$var2,$if,$oper1,$condition,$oper2 = $line.split()
    Write-Debug "parsing $var1,$instruction,$var2,$if,$oper1,$condition,$oper2"

    #check if value exists in register - assign 0
    if($register[$var1] -like $null) { $Register[$var1] = 0 }
    if($register[$oper1] -like $null) { $Register[$oper1] = 0 }

    $cont = $false
    #check if condition is true
    switch ($condition) {
        "==" { if([int]$register[$oper1] -eq [int]$oper2) {$cont = $true} }
        "!=" { if([int]$register[$oper1] -ne [int]$oper2) {$cont = $true} }
        ">" { if([int]$register[$oper1] -gt [int]$oper2) {$cont = $true} }
        ">=" { if([int]$register[$oper1] -ge [int]$oper2) {$cont = $true} }
        "<" { if([int]$register[$oper1] -lt [int]$oper2) {$cont = $true} }
        "<=" { if([int]$register[$oper1] -le [int]$oper2) {$cont = $true} }
    }



    if ($cont -eq $true) {

        switch ($instruction) {
            
            "inc" {
                Write-Debug "inc $var1 by $var2"
                $register[$var1] = $register[$var1] + [int]$var2
                Write-Debug "$($register[$var1])"
            }

            "dec" {
                Write-Debug "dec $var1 by $var2"
                $register[$var1] = $register[$var1] - [int]$var2
                Write-Debug "$($register[$var1])"
            }

        }

    }

    if ($register[$var1] -gt $p2) {
        $p2 = $register[$var1]
    }

    #$register.GetEnumerator() | Sort-Object -Property Name
    #Read-Host
}

$measure = $register.Values | Measure-Object  -Maximum

Write-Host "Part 1: $($measure.Maximum)" -ForegroundColor Green
Write-Host "Part 2: $p2" -ForegroundColor Green
