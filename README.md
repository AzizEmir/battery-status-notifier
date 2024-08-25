<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/8977/8977816.png" alt="Battery Save Icon" width="100"/> <br/>
The bash script monitors battery status and sends a notification if the battery level is above 80% while charging, and plays an audio alert. It also provides a low battery warning with audio when the level drops below 54%.
</p>

![codesnap](https://github.com/user-attachments/assets/ad908fa1-8567-4300-a6ee-ca68286cbd0d)

### crontab

```
*/1 * * * * /usr/local/bin/battery-monitor.sh
```

### Battery Monitor Enable/Disable Scripts

This repository includes two scripts to manage the battery monitor cron job:

- `disable-battery-monitor.sh`: Comments out the battery monitor cron job.
- `enable-battery-monitor.sh`: Uncomments the battery monitor cron job.


![image](Code_batcat_disable-battery.png)

![image](Code_batcat_enable-battery.png)
