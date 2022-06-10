# timeoff-management
This Dockerfile makes downloads the latest timeoff-management from git hub and builds it into an image that has easily configurable environment varible for the main config.


## Building
```
sudo docker build --no-cache -t timeoff-lsio:1.4.0b23
```

## Running
Here is an example docker-compose.yml
```
version: '3'

services:
  timeoff:
    image: timeoff-lsio:1.4.0b23

    restart: always
    ports: 
      - 3000:3000
    volumes:
      - /srv/Data/Timeoff/data:/data
    labels:
      - com.centurylinklabs.watchtower.enable=false
    environment:
      - APPLICATION_DOMAIN=<subdomain of site>
      - PROMOTION_WEBSITE_DOMAIN=<site domain>
      - SEND_EMAILS=true
      - EMAIL_FROM=<from address>
      - EMAIL_HOST=<smtp host>
      - EMAIL_PORT=<smtp port>
      - EMAIL_SSL=true
      - EMAIL_TLS=true
      - EMAIL_USER=<email user>
      - EMAIL_PASS=<email password>
      - CRYPTO_SECRET=<crypto secret>
```

### Environment variables
All of these variables are optional. If none are set then default settings from timeoff are used.

- ALLOW_CREATE_NEW_ACCOUNTS={true/false} -default: true
- SEND_EMAILS={true/false} -default: false
- EMAIL_FROM= -default: email@test.com
- EMAIL_HOST= -default: localhost
- EMAIL_PORT= -default: 25
- EMAIL_SSL={true/false} -default: false
- EMAIL_TLS={true/false} -default: true
- EMAIL_USER= -default: user
- EMAIL_PASS= -default: pass
- USE_REDIS={true/false} -default: false
- REDIS_HOST= -default: localhost
- REDIS_PORT= -default: 6379
- GA_ANALYTICS_ON={true/false} -default: false
- CRYPTO_SECRET -default: !2~lHswpPPLa22+=±§sdq qwe,appp qwwokDF_
- APPLICATION_DOMAIN= -default: http://app.timeoff.management
- PROMOTION_WEBSITE_DOMAIN= -default: http://timeoff.management
- LOCALE_CODE_FOR_SORTING= -default: en