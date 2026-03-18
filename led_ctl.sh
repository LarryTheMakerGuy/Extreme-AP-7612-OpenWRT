#!/bin/sh

LED_green="/sys/class/leds/ap7612:green:gateway"
TARGET_green="192.168.1.1"
LED_blue="/sys/class/leds/ap7612:blue:dns"
TARGET_blue="1.1.1.1"
LED_orange="/sys/class/leds/ap7612:orange:power"

echo none > "$LED_orange/trigger"
echo 1 > "$LED_orange/brightness"


while true; do
    if ping -c 3 -W 1 "$TARGET_green" >/dev/null 2>&1; then
        echo none > "$LED_green/trigger"
        echo 1 > "$LED_green/brightness"
    else
        echo none > "$LED_green/trigger"
        echo 0 > "$LED_green/brightness"

    fi
    if ping -c 3 -W 1 "$TARGET_blue" >/dev/null 2>&1; then
        echo none > "$LED_blue/trigger"
        echo 1 > "$LED_blue/brightness"
    else
        echo none > "$LED_blue/trigger"
        echo 0 > "$LED_blue/brightness"
    fi
    sleep 30
done

