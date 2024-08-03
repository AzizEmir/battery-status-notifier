#!/bin/bash

# Crontab dosyasını geçici bir dosyaya kaydet
crontab -l > /tmp/current_cron

# Battery monitor satırını yorum satırına dönüştür
sed -i 's|^\(\*/1 \* \* \* \* /usr/local/bin/battery-monitor.sh\)|#\1|' /tmp/current_cron

# Güncellenmiş crontab dosyasını yükle
crontab /tmp/current_cron

# Geçici dosyayı sil
rm /tmp/current_cron

echo "Battery monitor cron job has been disabled."

