<p align="center">
  <img src="https://cdn-icons-png.flaticon.com/512/8977/8977816.png" alt="Battery Save Icon" width="100"/> <br/>
The bash script monitors battery status and sends a notification if the battery level is above 84% and the battery is charging.
</p> 


![image](https://github.com/user-attachments/assets/ef5be220-c1fa-4b03-9539-58a0ba604f71)

### crontab

```
*/1 * * * * /usr/local/bin/battery-monitor.sh
```
