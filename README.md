# bash-mqtt-server-temp

bash script to publish server's temperture to mqtt broker as JSON

- using sh on lightweight alpine
- but you need to install

```bash
apk update && apk add jq mosquitto-clients
```

### You can pass parameter time after script in seconds (defalut= 60 seconds)

```bash
ash pub-temp.sh 30
```

## What you can expect after lunching this script

```bash
Temperture of Core 11 is 38
Temperture of Core 12 is 39
Temperture of Package id 0 is 42
Temperture of Core 0 is 36
Temperture of Core 1 is 38
Temperture of Core 2 is 37
Temperture of Core 3 is 37
Temperture of Core 4 is 36
Temperture of Core 8 is 37
Temperture of Core 9 is 37
Temperture of Core 10 is 38
Temperture of GPU is 66
repeating next 60 seconds...
```

## Reslutes will be published on mqtt as json like this:

```json
{
  "Server": "StrongServer",
  "Core 11": 38,
  "Core 12": 38,
  "Package id 0": 41,
  "Core 0": 36,
  "Core 1": 38,
  "Core 2": 36,
  "Core 3": 38,
  "Core 4": 38,
  "Core 8": 38,
  "Core 9": 37,
  "Core 10": 36,
  "GPU_Temp": 66
}
```
