#!/bin/bash

mkdir /tmp/vaping

sudo wget https://raw.githubusercontent.com/jacktooandroid/vaping/main/Configuration/config.yml -O /tmp/vaping/config.yml
sudo curl https://raw.githubusercontent.com/jacktooandroid/vaping/main/Configuration/config.yml -o /tmp/vaping/config.yml

sha256sum /tmp/vaping/config.yml | head -c 64 | sudo tee /tmp/vaping/GitHub_config > /dev/null
sha256sum /etc/vaping/config.d/config.yml | head -c 64 | sudo tee /tmp/vaping/Local_config > /dev/null

GitHub_config=$(cat /tmp/vaping/GitHub_config)
Local_config=$(cat /tmp/vaping/Local_config)

if [ "$GitHub_config" = "$Local_config" ]
    then
        echo "No changes detected. Exiting."
        exit
    else
        echo "Changes detected. Replacing with newer version now."
        sudo cp /tmp/vaping/config.yml /etc/vaping/config.d/config.yml
        vaping restart --home=/etc/vaping/config.d/
        exit
fi

exit