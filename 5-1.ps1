$in = get-content -path "D:\git\adventofcode\in\day5.txt"
#$in = get-content -path "D:\git\adventofcode\in\day4test.txt"

$instructionlist = New-Object System.Collections.ArrayList

foreach ($string in $in) {
    $instructionlist.Add($string -as [int]) > $null
}

$max = $instructionlist | Measure-Object  -Maximum
$min = $instructionlist | Measure-Object  -Minimum
$count = $instructionlist.Count



$steps = 0
$currentpos = 0
$currentval = 0

while ($currentpos -lt $count) {
    
    #read current value
    $currentval = $instructionlist[$currentpos]
    Write-Debug "Read current Value: $currentval"
    
    #remember oldpos
    $oldpos = $currentpos

    #jump with offset
    $currentpos = $currentpos + $currentval
    Write-Debug "after Jump: $currentpos (increased by $currentval)"

    #count Steps
    $steps++

    #Oldpos +1
    $instructionlist[$oldpos] = $instructionlist[$oldpos] + 1 #$instructionlist[$currentpos] += 1
}

Write-host "Steps taken: $steps" -ForegroundColor Green
#337020 too low
#337021 too low