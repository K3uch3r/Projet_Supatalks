echo ""
Write-Host "
███████╗██╗   ██╗██████╗  █████╗ ████████╗ █████╗ ██╗     ██╗  ██╗███████╗
██╔════╝██║   ██║██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██║     ██║ ██╔╝██╔════╝
███████╗██║   ██║██████╔╝███████║   ██║   ███████║██║     █████╔╝ ███████╗
╚════██║██║   ██║██╔═══╝ ██╔══██║   ██║   ██╔══██║██║     ██╔═██╗ ╚════██║
███████║╚██████╔╝██║     ██║  ██║   ██║   ██║  ██║███████╗██║  ██╗███████║
╚══════╝ ╚═════╝ ╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝
"
echo ""

function run {
$csv = Import-Csv "$(pwd)/intervenant.csv"
#$csv | Format-Table

#HTML creation
$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supatalks</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        img {
            max-width: 100px;
            max-height: 100px;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <h1>Supatalks</h1>
    <table>
        <tr>
"@

foreach ($colonne in $csv[0].PSObject.Properties) {
    $html += "<th>$($colonne.Name)</th>"
}
$html += "</tr>"

foreach ($ligne in $csv) {
    $html += "<tr>"
    foreach ($value in $ligne.PSObject.Properties.Value) {
        if ($value -like "*.jpg") {
            $html += "<td><img src='$value'></td>"
        } else {
            $html += "<td>$value</td>"
    }
}
    $html += "</tr>"
}

$html += @"
    </table>
</body>
</html>
"@

$html | Out-File -FilePath "$(pwd)/data.html" -Encoding UTF8

}
run
