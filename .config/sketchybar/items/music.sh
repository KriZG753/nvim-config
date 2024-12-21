music=(
  script="$PLUGIN_DIR/music.sh"
  label.padding_right=8
  label.font="OperatorMono Nerd Font:Book Italic:15.0"
  padding_right=16
  icon="󰎈" # Set the icon for music
  label.drawing=off # Hide the label
  scroll_text=false
  background.image.media.artwork
  background.image.scale=0.9
  background.image.corner_radius=8
  border_color="$RED"
  background.color="$TRANSPARENT"
  icon.padding_left=8
  label.max_chars=15
  label.align=center
  label.width=130
  popup.align=right
  script="$PLUGIN_DIR/music.sh"
  click_script="sketchybar --set \$NAME popup.drawing=toggle"
)

sketchybar --add item music center \
           --set music "${music[@]}" \
           --subscribe music mouse.entered \
                               mouse.exited \
                               mouse.exited.global
