#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title bilixv (Chrome)
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description use bilix v to download videos from chrome url
# @raycast.author HFrost0
# @raycast.authorURL https://github.com/HFrost0

on run
    tell application "Google Chrome"
        set currentURL to URL of active tab of front window
    end tell
    set command to "bilix v " & quoted form of currentURL & " --path ~/videos --browser chrome"
    tell application "iTerm"
        activate
        if (exists current window) then
            tell current window
                tell current session
                    write text command
                end tell
            end tell
        else
            set newWindow to (create window with default profile)
            tell newWindow
                select
                tell current session
                    write text command
                end tell
            end tell
        end if
    end tell
end run
