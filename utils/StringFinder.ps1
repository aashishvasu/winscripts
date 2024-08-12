param (
    [string]$SearchString,
    [string]$TargetDirectory = ".",
    [string]$FileExtension = "*",
    [Alias("h", "?")][switch]$Help
)

function Show-Help
{
    Write-Host @"
Usage: .\SearchTextInFiles.ps1 -SearchString <string> [-TargetDirectory <path>] [-FileExtension <extension>] [-Help]

Parameters:
    -SearchString    (Required) The text string to search for in the files.
    -TargetDirectory (Optional) The directory to search in. Defaults to the current directory.
    -FileExtension   (Optional) The file extension to filter by. Defaults to all files (*).
    -Help, -h, -?    Displays this help message.
"@
}

if ($Help -or -not $SearchString)
{
    Show-Help
    exit
}

try
{
    # Get all files in the specified directory with the specified extension
    $FilesToSearch = Get-ChildItem -Path $TargetDirectory -Filter $FileExtension -File -ErrorAction Stop

    foreach ($File in $FilesToSearch)
    {
        # Use Select-String to search for the text string within the file
        $SearchResults = Select-String -Path $File.FullName -Pattern $SearchString -SimpleMatch

        if ($SearchResults)
        {
            # Output the file name if a match is found
            Write-Host $File.Name
        }
    }
}
catch
{
    Write-Error "An error occurred: $_"
}
