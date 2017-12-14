$DebugPreference = "Continue"

$in = Get-Content -Path "C:\Users\adm.spatt\Desktop\Neuer Ordner\day9.txt"

#$in = "{{{},{},{{}}}},"

$split = $in -split ""

$ignore = $false
$garbadge = $false
$score = 0
$group = 0
$score2 = 0


foreach ($char in $split) {

    Write-Debug "current char $char"

    if ($ignore) { $ignore = $false }
    elseif ($char -eq "!") { $ignore = $true }
    elseif ($garbadge -eq $true -and $char -ne '>') { $score2++}
    elseif ($char -eq "<") { $garbadge = $true }
    elseif ($char -eq ">") { $garbadge = $false }
    elseif ($char -eq "{") { $group++; Write-Debug "Increasing Group to $group" }
    elseif ($char -eq "}") { Write-Debug "Adding to Score $score + $group"; $score = $score + $group; $group--}
    
    Write-Debug "Current Score $score"

    }

Write-Host "Part 1: $score" -ForegroundColor Green
Write-Host "Part 2: $score2" -ForegroundColor Green
#1700 too low