$in = Get-Content -Path "C:\Users\adm.spatt\Desktop\day7.txt"
$in = Get-Content -Path "C:\Users\adm.spatt\Desktop\day7test.txt"

[regex]$regexsingle = "(?mi)^(?<name0>\w+) \((?<weight>\d+)\)$"

[regex]$regexmulti1 = "(?mi)^(?<name0>\w+) \((?<weight>\d+)\) -> (?<name1>\w+)$"


foreach ($line in $in) {
$line
}

