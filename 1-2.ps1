$val = get-content -path "D:\git\adventofcode\in\day1.txt"
#$val = "1212"
$arr = [int[]][string[]][char[]]$val


[int]$sum = 0
[int]$last = 0

[int]$length = $arr.Length
[int]$ahead = $length/2

For ($i=0; $i -lt $length; $i++) {

    $iahead = $i + $ahead
    
    write-host "current round $i"

    if ($iahead -ge $length){
        write-host "merry go round $iahead"
        $iahead = $iahead - $length
        write-host "new iahead $iahead"
    }


    if ($arr[$i] -eq $arr[$iahead]) {
        [int]$sum = $sum + $arr[$i]
    }

}

$sum
