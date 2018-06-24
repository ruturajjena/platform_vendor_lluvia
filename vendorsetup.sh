for combo in $(curl -s https://raw.githubusercontent.com/LLuviaOS/android_vendor_lluvia/llovizna-release/lluvia.devices | sed -e 's/#.*$//' | awk '{printf "lluvia_%s-%s\n", $1, $2}')
do
    add_lunch_combo $combo
done
