#!/bin/bash

update() {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  # Fetch unread emails from Outlook using AppleScript
  UNREAD_EMAILS=$(osascript <<EOF
tell application "Microsoft Outlook"
    set unreadCount to 0
    repeat with acct in mail accounts
        try
            set inboxFolder to inbox of acct
            set unreadCount to unreadCount + (count of messages of inboxFolder whose read status is false)
        end try
    end repeat
    return unreadCount
end tell
EOF
  )

  # Handle errors or empty responses
  if [ $? -ne 0 ] || [ -z "$UNREAD_EMAILS" ]; then
    UNREAD_EMAILS=0
  fi

  args=()
  if [ "$UNREAD_EMAILS" -eq 0 ]; then
    args+=(--set $NAME icon=$BELL label="0")
  else
    args+=(--set $NAME icon=$BELL_DOT label="$UNREAD_EMAILS")
  fi

  PREV_COUNT=$(sketchybar --query outlook.bell | jq -r .label.value)

  # Handle sound or visual effects for new emails
  if [ $UNREAD_EMAILS -gt $PREV_COUNT ] 2>/dev/null || [ "$SENDER" = "forced" ]; then
    sketchybar --animate tanh 15 --set outlook.bell label.y_offset=5 label.y_offset=0
  fi

  sketchybar -m "${args[@]}" > /dev/null
}

popup() {
  sketchybar --set $NAME popup.drawing=$1
}

case "$SENDER" in
  "routine"|"forced") update
  ;;
  "mouse.entered") popup on
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "mouse.clicked") popup toggle
  ;;
esac
