$in = @(0,2,7,0)
$in = @(11,11,13,7,0,15,5,5,4,4,1,1,7,1,15,11)
#$in = @(3,1,2,3)

$DebugPreference = "SilentlyContinue"
#$DebugPreference = "Continue"


$savedstate = @{}
$count = 0
$done = $false
$imax = $null

$savedstate.Add($count,"$($in.Clone())")
$count++


while ($done -ne $true) {

    $measuremax = $in | Measure-Object -Maximum

    #find highest value 
    for ($i=0; $i -lt $in.Count; $i++) {
        
        Write-Debug "highest value check $($measuremax.Maximum) - $($in[$i])"
        if ($measuremax.Maximum -eq $in[$i]) {
            $imax = $i
            Write-Debug "imax: $imax - value $($in[$imax])"
            break
        }
    }

    #store value to distribute
    $blockstoredistribute = $in[$imax]

    #reset memory block to 0
    $in[$imax] = 0

    #distribute value
    while ($blockstoredistribute -gt 0) {

        Write-Debug "Distributing $blockstoredistribute"

        $imax++
        #find first block to distribute
        if ($imax -ge $in.Count) {
            $imax = $imax - $in.Count
        }

        #distribute value and lower value to distribute.
        $in[$imax] = $in[$imax] +1
        $blockstoredistribute--
    }
    Write-Debug "current state $in"
    



    if ($savedstate.ContainsValue("$in")) {
        Write-Host "Answer1: $count" -ForegroundColor Green
        $done = $true

        for ($a=0;$a -lt $savedstate.Count;$a++) {
            if ($savedstate[$a] -eq "$in") {
                Write-Host "Answer2: $($($savedstate.Count) - $a)" -ForegroundColor Green
            }
        }

        break
    }


    #save block values
    Write-Debug "adding saved block $in to index"
    $savedstate.Add($count,"$($in.Clone())")
    $count++
    Write-Host $count
}


