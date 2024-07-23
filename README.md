# battery-status-notifier
The bash script monitors battery status and sends a notification if the battery level is above 84% and the battery is charging.

![image](https://github.com/user-attachments/assets/ef5be220-c1fa-4b03-9539-58a0ba604f71)

### crontab

```
*/1 * * * * /usr/local/bin/battery-monitor.sh
```
