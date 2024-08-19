param (
    [string]$Msg,
    [Alias("h", "?")][switch]$Help
)

function Show-Help
{
    Write-Host @"
Usage: .\PromptUserInput.ps1 [-Msg <string>] [-Help]

Parameters:
    -Msg          (Optional) The message to display directly. If provided, the script will echo this message without prompting.
    -Help, -h, -? Displays this help message.
"@
}

function Output-Message {
    param (
        [string]$Message
    )
    Write-Output $Message
}

if ($Help)
{
    Show-Help
    exit
}

try
{
    if ($Msg)
    {
        # Echo the provided message
        Output-Message -Message $Msg
    }
    else
    {
        # Prompt the user for input
        $userInput = Read-Host -Prompt "Please enter something"

        # Echo the input back to the user
        Output-Message -Message $userInput
    }
}
catch
{
    Write-Error "An error occurred: $_"
}
