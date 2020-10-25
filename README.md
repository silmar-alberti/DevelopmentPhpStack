## Development PHP Stack
___
### Description

### Features
- PHP `5.6`, `7.2` and `7.4`
- ever images own base, dev and prod variants 


### Dependencies
 - [Docker](https://docs.docker.com/install/) 
 - [Docker-compose](https://docs.docker.com/compose/install/)
### Setup

1. Clone this project: 
    ```SH
    git clone git@github.com:silmar-alberti/DevelopmentPhpStack.git
    ```

2. Open `deploy` folder: 
    ```SH
    cd deploy
    ```

3. Setup apache config files in `php56-sites-enabled` or `php72-sites-enabled` 
    ``` Apache
    <VirtualHost *:80>
        ServerName *.php7.localhost.com
        DocumentRoot /var/www/site

        <Directory /var/www/html/site>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>

    ```

4. Start your dev env with command:

    ``` SH
    bash ./start.sh
    ``` 
    obs: this stript works in fedora 31,32. but not tested on another distribution or version.

    This stript only make `./deploy/.env` file used in containers setup to redirect xdebug requests. **check that the firewall does not close port 9000.** 
___
### Details

#### Request forward

- This project use nginx-proxy to forward requests to both environments. 
See file ./deploy/docker-compose.yml and [nginx-proxy documentation](https://github.com/nginx-proxy/nginx-proxy)

#### Xdebug debug 
- Check `deploy/.env` content, 
    ``` 
    HOST_DOCKER_INTERNAL=your external ip
    ```
    if not sure, fix and restart apache services.     
- Xdebug start with trigger XDEBUG_SESSION_START [see more on docs](https://xdebug.org/docs/remote)

- **Check that the firewall does not close port 9000.** 

#### Xdebug Profile
- Profile files are maked on `/tmp/profiler` folder, 
- To start xdebug profile set session cookie or GET parameter [see more on xdebug docs](https://xdebug.org/docs/profiler)

___
### Utils

 - This project also try abstract local php tools how commands: `php56`, `php72`, `composer` and `kcacheGrid`(xdebug profile analyzer). 
 see command files on `./utils` folder

#### Install nnative commands (linux only)
1. To install php, composer and kcacheGrid run follow command:
```SH
sudo bash devPhpInstall
```
2. Enable debugCliSession 
```SH
source enableDebugVars
```
3. Disable debugCliSession 
```SH
source disableDebugVars
```
___
### Used repositories 
- [php](https://hub.docker.com/r/_/php)
- [jwilder/nginx-proxy](https://hub.docker.com/r/jwilder/nginx-proxy/)
- [quetzacoalt/kcachegrind](https://hub.docker.com/r/quetzacoalt/kcachegrind)
- [tini](https://github.com/krallin/tini)


