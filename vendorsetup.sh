for combo in $(curl -s https://github.com/LLuviaOS/platform_vendor_lluvia/blob/llovizna-release/lluvia.devices | sed -e 's/#.*$//' | awk '{printf "lluvia_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
