$val = get-content -path "D:\git\adventofcode\in\day1.txt"

#val = "1122"
$arr = [int[]][string[]][char[]]$val


[int]$sum = 0
[int]$last = 0

$start = $null
$end = $null

foreach ($num in $arr) {
    if ([string]::IsNullOrEmpty($start)) {
        $start = $num
    }

    write-host "doing $num - last was $last sum is $sum"
    
    if ($num -eq $last) {
        write-host "gotcha $num eq $last sum is $sum"
        $sum = $sum + $num
        write-host "new sum $sum"
    }


    $last = $num
}

if ($start -eq $num) {
    Write-host "start was $start - last num was $num"
    $sum = $sum + $start
}

$sum