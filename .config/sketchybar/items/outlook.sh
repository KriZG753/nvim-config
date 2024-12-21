outlook_bell=(
  update_freq=60
  icon.font="FONT:Bold:15.0"
  icon=$BELL
  icon.color=$BLUE
  label="LOADING"
  label.highlight_color=$BLUE
  popup.align=right
  script="$PLUGIN_DIR/outlook.sh"
  click_script="sketchybar --set \$NAME popup.drawing=toggle"
)

sketchybar --add item outlook.bell right \
           --set outlook.bell "${outlook_bell[@]}" \
           --subscribe outlook.bell mouse.entered \
                                       mouse.exited \
                                       mouse.exited.global

outlook_template=(
  drawing=off
  background.corner_radius=12
  padding_left=7
  padding_right=7
  background.height=2
  background.y_offset=-12
)

sketchybar --add item outlook.template popup.outlook.bell \
           --set outlook.template "${outlook_template[@]}"
