[int]$in = 361527
#[int]$in = 25

$cssize = [math]::Sqrt($in)
$cssize =  [math]::Ceiling($cssize) / 2
$cssize =  [math]::Ceiling($cssize) + 1

$x = 0
$y = 0

$cs = @{}
$cstmp = @{}

for ([int]$i = $($cssize * -1); $i -le $cssize; $i++) {

    $cstmp[$i] = @{}
    $cs.add($i,$cstmp[$i])

}

$cs[0][0] = 1

$val = 0


function CS {
    write-host "$($cs[-2][2])`t$($cs[-1][2])`t$($cs[0][2])`t$($cs[1][2])`t$($cs[2][2])"
    write-host "$($cs[-2][1])`t$($cs[-1][1])`t$($cs[0][1])`t$($cs[1][1])`t$($cs[2][1])"
    write-host "$($cs[-2][0])`t$($cs[-1][0])`t$($cs[0][0])`t$($cs[1][0])`t$($cs[2][0])"
    write-host "$($cs[-2][-1])`t$($cs[-1][-1])`t$($cs[0][-1])`t$($cs[1][-1])`t$($cs[2][-1])"
    write-host "$($cs[-2][-2])`t$($cs[-1][-2])`t$($cs[0][-2])`t$($cs[1][-2])`t$($cs[2][-2])"
}

function GetNeighborSum ($xcoord, $ycoord) {

    #links (x-1 , y)
    #unten (x, y-1)
    #rechts (x+1,y)
    #oben (x, y+1)

    $left = $cs[$($xcoord-1)][$ycoord]
    $down = $cs[$xcoord][$($ycoord-1)]
    $right = $cs[$($xcoord+1)][$ycoord]
    $up = $cs[$xcoord][$($ycoord+1)]

    $leftdown = $cs[$($xcoord-1)][$($ycoord-1)]
    $downright = $cs[$($xcoord+1)][$($ycoord-1)]
    $rightup = $cs[$($xcoord+1)][$($ycoord+1)]
    $upleft = $cs[$($xcoord-1)][$($ycoord+1)]

    $sum = $left + $down + $right + $up + $leftdown + $downright + $rightup + $upleft

    if ($left -ge $in) {
        Write-host "Answer left: $left" -ForegroundColor Green
        throw "end"
    }
    elseif ($down -ge $in) {
        Write-host "Answer down: $down" -ForegroundColor Green
        throw "end"
    }
    elseif ($right -ge $in) {
        Write-host "Answer right: $right" -ForegroundColor Green
        throw "end"
    }
    elseif ($up -ge $in) {
        Write-host "Answer up: $up" -ForegroundColor Green
        throw "end"
    }
    elseif ($leftdown -ge $in) {
        Write-host "Answer up: $leftdown" -ForegroundColor Green
        throw "end"
    }
    elseif ($downright -ge $in) {
        Write-host "Answer up: $downright" -ForegroundColor Green
        throw "end"
    }
    elseif ($rightup -ge $in) {
        Write-host "Answer up: $rightup" -ForegroundColor Green
        throw "end"
    }
    elseif ($upleft -ge $in) {
        Write-host "Answer up: $upleft" -ForegroundColor Green
        throw "end"
    }
    else {
        Write-host "Current Sum: L$left + D$down + R$right + U$up +LD$leftdown + DR$downright + RU$rightup + UL$upleft = $sum" -ForegroundColor Magenta
    }

    return $sum

}

for ($num = 2; $num -le $in; $num++) {
    write-debug "Coord Number $num"
    #Write-Progress -Activity "Creating Coordinate System for $in" -status "Current Number: $num" -percentComplete ($num / $in*100)
    <#
    1-2
    links (x-1 , y) null ist
    unten (x, y-1) null ist
    rechts (x+1,y) null ist
    oben (x, y+1) null ist
    gehe eins nach rechts (x+1,y)
    #>
    if (`
    ($cs[$($x-1)][$y]) -eq $null`
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "1-2 - x: $x y: $y"

        $x++

        $val = GetNeighborSum $x $y

        $cs[$x][$y] = $val
        
   
    } 


    <#
    2-3
    links (x-1 , y) nicht null ist
    unten (x, y-1) null ist
    rechts (x+1,y) null ist
    oben (x, y+1) null ist
    gehe eins nach oben (x,y+1)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -ne $null) `
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "2-3 - x: $x y: $y"
        $y++
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val

    }
    <#
    3-4
    links (x-1 , y)  null ist
    unten (x, y-1) nicht null ist
    rechts (x+1,y) null ist
    oben (x, y+1) null ist
    gehe eins nach links (x-1,y)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -eq $null) `
    -and ($cs[$x][$($y-1)] -ne $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "3-4 - x: $x y: $y"
        $x--
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    4-5
    links (x-1 , y)  null ist
    unten (x, y-1) nicht null ist
    rechts (x+1,y) nicht null ist
    oben (x, y+1) null ist
    gehe eins nach links (x-1,y)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -eq $null) `
    -and ($cs[$x][$($y-1)] -ne $null) `
    -and ($cs[$($x+1)][$y] -ne $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "4-5 - x: $x y: $y"
        $x--
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    5-6
    links (x-1 , y)  null ist
    unten (x, y-1)  null ist
    rechts (x+1,y) nicht null ist
    oben (x, y+1) null ist
    gehe eins nach unten (x,y-1)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -eq $null) `
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -ne $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "5-6 - x: $x y: $y"
        $y--
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    6-7
    links (x-1 , y)  null ist
    unten (x, y-1)  null ist
    rechts (x+1,y) nicht null ist
    oben (x, y+1) nicht null ist
    gehe eins nach unten (x,y-1)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -eq $null) `
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -ne $null)`
    -and ($cs[$x][$($y+1)] -ne $null)) {
        write-debug "6-7 - x: $x y: $y"
        $y--
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    7-8
    links (x-1 , y)  null ist
    unten (x, y-1)  null ist
    rechts (x+1,y)  null ist
    oben (x, y+1) nicht null ist
    gehe eins nach rechts (x+1,y)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -eq $null) `
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -ne $null)) {
        write-debug "7-8 - x: $x y: $y"
        $x++
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    8-9
    links (x-1 , y) nicht null ist
    unten (x, y-1)  null ist
    rechts (x+1,y)  null ist
    oben (x, y+1) nicht null ist
    gehe eins nach rechts (x+1,y)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -ne $null) `
    -and ($cs[$x][$($y-1)] -eq $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -ne $null)) {
        write-debug "8-9 - x: $x y: $y"
        $x++
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    <#
    11-12
    links (x-1 , y) nicht null ist
    unten (x, y-1)  nicht null ist
    rechts (x+1,y)  null ist
    oben (x, y+1)  null ist
    gehe eins nach oben (x,y+1)
    #>
    elseif (`
    ($cs[$($x-1)][$y] -ne $null) `
    -and ($cs[$x][$($y-1)] -ne $null) `
    -and ($cs[$($x+1)][$y] -eq $null)`
    -and ($cs[$x][$($y+1)] -eq $null)) {
        write-debug "1-12 - x: $x y: $y"
        $y++
        $val = GetNeighborSum $x $y
        $cs[$x][$y] = $val
        
    }

    #Read-Host "pause"

}

