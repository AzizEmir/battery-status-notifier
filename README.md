<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/8977/8977816.png" alt="Battery Save Icon" width="100"/> <br/>
The bash script monitors battery status and sends a notification if the battery level is above 80% while charging, and plays an audio alert. It also provides a low battery warning with audio when the level drops below 54%.
</p>

![image](Code_batcat_screenshot.png)

### crontab

```
*/1 * * * * /usr/local/bin/battery-monitor.sh
```
