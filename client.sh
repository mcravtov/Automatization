#!/bin/bash
## Define variables
user=$1 	# Param for initiating script (user)
env=$2 		# Param for initiating script (environment)
pass=$3		# Param for initiating script (client name)
port=$4		# APP port
passdb=$5
domaines="${user}.easyscreen.io"
domainadmin="admin-${user}.easyscreen.io"
passwordUser="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c9)"
passwordDb="$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c9)"

if [ "${env}" == "stg" ]; 
then
	domaines="${user}.stg.easyscreen.io"
	domainadmin="admin-${user}.stg.easyscreen.io"
fi

## Create client and domains in Vesta
	/usr/local/vesta/bin/v-add-user ${user} ${passwordUser} ${user}@easyscreen.io
	/usr/local/vesta/bin/v-add-domain ${user} ${domaines}
	/usr/local/vesta/bin/v-add-domain ${user} ${domainadmin}
	/usr/local/vesta/bin/v-add-database ${user} db db ${passwordDb}

## Add port to nginx
## Need a way to automatically find available port for the client and add it to nginx.

## Configure Jenkins
## Need to copy the user key created by "v-add-user" to Jenkins, so it can rsync on build script.
##Need to add the {$user} to the select list in both manager and client Jenkins projects.

## Configure Manager
##cd /home/{$user}/web/
##cd {$user}.v2.easyscreen.inlead.dk/public_html
##rm -rf index.html robots.txt
##cp app/config/parameters.yml.dist app/config/parameters.yml
##echo "" > app/config/security.yml
##composer install // NEED PARAMS
##php app/console cache:clear --env=prod
##php app/console doctrine:schema:create
##php app/console es:initialize

## Configure Client
##cd /home/{$user}/web/
##cd $domain/public_html
##rm -rf index.html robots.txt
## Need to use the port we defined earlier
##cp config.json.example config.json
## Need parameters to define here ($3 for sure, but also mobile search, lms, etc. Maybe it should be done with composer?
##cp static/src/config.js.example static/src/config.js
##pm2 start server.js --ignore-watch cache --name {$env}
