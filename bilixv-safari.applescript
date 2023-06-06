#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title bilixv (Safari)
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🦁

# Documentation:
# @raycast.description use bilix v to download videos from safari url
# @raycast.author HFrost0
# @raycast.authorURL https://github.com/HFrost0

on run
    tell application "Safari"
        set currentURL to URL of front document
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
