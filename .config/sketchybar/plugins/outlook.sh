#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

update() {
  UNREAD_EMAILS=$(osascript <<EOF
tell application "Microsoft Outlook"
    set unreadSubjects to {}
    try
        repeat with acct in mail accounts
            set inboxFolder to inbox of acct
            set unreadMessages to (every message of inboxFolder whose read status is false)
            repeat with msg in unreadMessages
                set end of unreadSubjects to subject of msg
            end repeat
        end repeat
    on error errMsg
        return {"Error: " & errMsg}
    end try
    return unreadSubjects
end tell
EOF
  )

  SUBJECTS=($(echo "$UNREAD_EMAILS" | tr ',' '\n'))
  args=()

  if [ ${#SUBJECTS[@]} -eq 0 ]; then
    args+=(--set $NAME icon=$BELL label="0")
    args+=(--remove '/outlook.notification\.*/')
    notification=(
      label="No Unread Emails"
      icon="" # Removed icon here
      icon.padding_left=10
      label.padding_right=10
      position=popup.outlook.bell
      drawing=on
    )
    args+=(--clone outlook.notification.1 outlook.template \
           --set outlook.notification.1 "${notification[@]}")
  else
    args+=(--set $NAME icon=$BELL_DOT label="${#SUBJECTS[@]}")
    args+=(--remove '/outlook.notification\.*/')

    COUNTER=0
    for subject in "${SUBJECTS[@]}"; do
      COUNTER=$((COUNTER + 1))
      notification=(
        label="$subject"
        icon="" # Removed icon here
        icon.padding_left=10
        label.padding_right=10
        position=popup.outlook.bell
        drawing=on
      )
      args+=(--clone outlook.notification.$COUNTER outlook.template \
             --set outlook.notification.$COUNTER "${notification[@]}")
    done
  fi

  sketchybar -m "${args[@]}"
}

popup() {
  sketchybar --set $NAME popup.drawing=$1
}

case "$SENDER" in
  "routine"|"forced") update ;;
  "mouse.entered") popup on ;;
  "mouse.exited"|"mouse.exited.global") popup off ;;
  "mouse.clicked") popup toggle ;;
esac
