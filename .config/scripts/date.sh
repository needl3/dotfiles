#!/usr/bin/bash
if [ ! -f /tmp/nepali_date ];
then
        if ! curl -f -s --connect-timeout 5 https://nepalicalendar.rat32.com/ | grep '"gate"\|"mth"\|"yr"' > /tmp/tmp_nepali;
        then
                printf "Cannot fetch data right now."
                exit 1
        fi
        grep -o -P '(?<=<div id="gate" style="\/\*margin-top:15px;margin-bottom:15px\*\/">).*(?=&nbsp;)' /tmp/tmp_nepali >> /tmp/nepali_date
        grep -o -P '(?<=<div id="mth">&nbsp;).*(?=<\/div>)' /tmp/tmp_nepali >> /tmp/nepali_date
        grep -o -P '(?<=<div id="yr"> ).*(?= Year)' /tmp/tmp_nepali >> /tmp/nepali_date
        rm /tmp/tmp_nepali
fi
notify-send "$(cat /tmp/nepali_date | tr '\n' ' ')"
notify-send "$(date)"
