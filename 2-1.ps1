$val = get-content -path "D:\git\adventofcode\in\day2.txt"


$sum = 0
$checksum = 0


foreach ($row in $val) {
    write-host "row: $row"
    [int]$highnum = 0 #hax
    [int]$lownum = 999999 #dirtyhax

    $rownum = $row.Split("`t")

    foreach ($strnum in $rownum) {
    
    $num = [int]$strnum #F**K STRINGS disguised as INTEGERS

    write-host "current num $num"
    
        if ($num -ge $highnum) {
            write-host "yey $num is greater than $highnum"
            $highnum = $num
        }
        

        if ($num -le $lownum) {
                write-host "yey $num is lower than $lownum"
            $lownum = $num
        }

    }
    $sum = $highnum - $lownum 
    $checksum = $checksum + $sum
    write-host "current `t $highnum-$lownum=$sum"

}

write-host "checksum: $checksum"
