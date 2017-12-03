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


for ($num = 2; $num -le $in; $num++) {
    write-debug $num
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
        $cs[$($x+1)][$y] = $num
        $x++
   
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
        $cs[$x][$($y+1)] = $num
        $y++

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
        $cs[$($x-1)][$y] = $num
        $x--
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
        $cs[$($x-1)][$y] = $num
        $x--
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
        $cs[$x][$($y-1)] = $num
        $y--
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
        $cs[$x][$($y-1)] = $num
        $y--
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
        $cs[$($x+1)][$y] = $num
        $x++
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
        $cs[$($x+1)][$y] = $num
        $x++
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
        $cs[$x][$($y+1)] = $num
        $y++
    }

    if ($num -eq $in) {
        Write-host "$num at x: $x y: $y"
        if ($x -lt 0) { $answerx = $x * -1 } else { $answerx = $x }
        if ($y -lt 0) { $answery = $y * -1 } else { $answery = $y }
        Write-host "answer: $($answerx+$answery)"
    }
}
