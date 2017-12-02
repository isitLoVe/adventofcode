$val = get-content -path "D:\git\adventofcode\in\day2.txt"
#$val = get-content -path "D:\git\adventofcode\in\day2test.txt"

$sum = 0
$checksum = 0
$div = $null


foreach ($row in $val) {
    write-host "row: $row"

    $rowarr = $row.Split("`t")

    foreach ($strnum in $rowarr) {
        $num = [int]$strnum #F**K STRINGS disguised as INTEGERS
 
        $div = $rowarr | Where-Object {$_ -ne $num} | Where-Object {$_ % $num -eq 0}
        
        if ($div){
            write-host "division $div / $num = $($div/$num)"
            #$checksum = $checksum + $div / $num
            $checksum += $div / $num
        }
    }
}

write-host "checksum: $checksum"
