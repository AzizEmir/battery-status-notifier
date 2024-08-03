#!/bin/bash

# Crontab dosyasını geçici bir dosyaya kaydet
crontab -l > /tmp/current_cron

# Yorum satırındaki battery monitor satırını aktif hale getir
sed -i 's|^#\(\*/1 \* \* \* \* /usr/local/bin/battery-monitor.sh\)|\1|' /tmp/current_cron

# Güncellenmiş crontab dosyasını yükle
crontab /tmp/current_cron

# Geçici dosyayı sil
rm /tmp/current_cron

echo "Battery monitor cron job has been enabled."

