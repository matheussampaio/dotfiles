#!/bin/bash

# <bitbar.title>Slack users deactivated</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Matheus Sampaio</bitbar.author>
# <bitbar.author.github>matheussampaio</bitbar.author.github>
# <bitbar.desc>Read mail and display how many users was deactivated from Slack.</bitbar.desc>

cat /var/mail/matheussampaio | grep "^To: matheussampaio" | wc -l

echo "---"

cat /var/mail/matheussampaio | grep "deactivated at" | cut -f 1 -d " "

echo "---"

echo "Delete all | color=red ansi=false terminal=false refresh=true bash=/Users/matheussampaio/git/dotfiles/slack/delete-emails.sh"
