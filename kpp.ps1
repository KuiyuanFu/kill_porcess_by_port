param($port)

$netstatReturn = (netstat -ano)

foreach ($netstatInfo in $netstatReturn) {

    if ( $netstatInfo.Contains($port )) {
        
        $ls = New-Object System.Collections.Generic.List[System.Object]

        
        foreach ($item in $netstatInfo.Split()) {

            if ($item.Length -ne "0") {

                $ls.Add($item)

            }
        }

        if ($ls[1].Split(':')[1] -eq $port) {

            $portPid = $ls[-1]

            (taskkill /F  /pid $portPid)

            write-host "kill $netstatInfo"

        }

    }

}

