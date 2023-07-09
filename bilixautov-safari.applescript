#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title bilixautov (Safari)
# @raycast.mode inline

# Optional parameters:
# @raycast.icon 🦁

# Documentation:
# @raycast.description use bilix autov to download videos from safari url
# @raycast.author HFrost0
# @raycast.authorURL https://github.com/HFrost0

on run
    try
        tell application "Safari"
            set currentTab to current tab of front window
            set currentURL to URL of front document
            set pageHTML to do JavaScript "
                var mainHTML = document.documentElement.outerHTML;
                var iframes = document.querySelectorAll('iframe');
                var iframeHTML = '';
                for(var i = 0; i < iframes.length; i++){
                    if(iframes[i].contentWindow){
                        iframeHTML += iframes[i].contentWindow.document.documentElement.outerHTML;
                    }
                }
                mainHTML + iframeHTML;
            " in currentTab
        end tell

        -- Save HTML to file
        set filePath to (path to home folder as text) & "videos:tmp.html"
        set fileRef to open for access file filePath with write permission
        set eof of fileRef to 0
        write pageHTML to fileRef as «class utf8»
        close access fileRef

        -- Run bilix command
        set bilixCommand to "bilix autov " & quoted form of currentURL & " --path ~/videos --html-strategy file --html-path " & quoted form of POSIX path of filePath
        tell application "iTerm"
            activate
            if (exists current window) then
                tell current window
                    tell current session
                        write text bilixCommand
                    end tell
                end tell
            else
                set newWindow to (create window with default profile)
                tell newWindow
                    select
                    tell current session
                        write text bilixCommand
                    end tell
                end tell
            end if
        end tell
    on error errMsg number errorNumber
        display dialog "Error " & errorNumber & ": " & errMsg
    end try
end run
