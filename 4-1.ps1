$val = get-content -path "D:\git\adventofcode\in\day4.txt"
#$val = get-content -path "D:\git\adventofcode\in\day4test.txt"

$dupes = 0

foreach ($passphrase in $val) {
    $words = $passphrase.Split(" ")
    if ($words | group-object | Where-Object -FilterScript {$_.Count -gt 1 }) {
        write-host "$words dupes found"
        $dupes++
    }
}

Write-host "Answer: $($($val.Count) - $dupes)"