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
	tell application "Safari"
		set currentTab to current tab of front window
		set currentURL to URL of front document
		set pageHTML to do JavaScript "
            var mainHTML = document.documentElement.outerHTML;
            var iframes = document.querySelectorAll('iframe');
            var iframeHTML = '';
            for(var i = 0; i < iframes.length; i++){
                if(iframes[i].contentWindow){
                    try {
                        iframeHTML += iframes[i].contentWindow.document.documentElement.outerHTML;
                    } catch(e) {
                        console.log(e.message);
                    }
                }
            }
            mainHTML + iframeHTML;
        " in currentTab
	end tell

	-- Save HTML to file
	set filePath to "~/videos/tmp.html"
	do shell script "echo " & quoted form of pageHTML & " > " & filePath

	-- Run bilix command
	set bilixCommand to "bilix autov " & quoted form of currentURL & " --path ~/videos --html-strategy file --html-path " & filePath
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
end run

