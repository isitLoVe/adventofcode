$val = get-content -path "D:\git\adventofcode\in\day4.txt"
#$val = get-content -path "D:\git\adventofcode\in\day4test.txt"

$dupes = 0
$anagrams = 0

foreach ($passphrase in $val) {
    $words = $passphrase.Split(" ")
    if ($words | group-object | Where-Object -FilterScript {$_.Count -gt 1 }) {
        write-host "$words dupes found" -ForegroundColor Red
        $dupes++
    }
    else {
        write-host "$words NO dupes found" -ForegroundColor Green
        foreach ($word in $words) {
            $wordsorted = ($word.ToLower().GetEnumerator() | Sort-Object) -join '' 

            foreach ($singleword in $words) {
            $found = $false
                $singlewordsorted = ($singleword.ToLower().GetEnumerator() | Sort-Object) -join '' 

                if (($singlewordsorted -eq $wordsorted) -and ($singleword -ne $word)) {
                    write-host "found anagram $singleword - $word"
                    $found = $true
                    break
                }
            }
            if ($found -eq $true) {
            $anagrams++
            break}

        }
    }
}

Write-host "Answer: $($($val.Count) - $dupes - $anagrams)"

