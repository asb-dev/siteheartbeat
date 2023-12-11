Site Heartbeat
===
Simple bash script to check if specified url response with correct code HTTP 200.

In case of bad response, the script will send a notification to Telegram chat.

How to use
---

1. Create bot in Telegram with @Botfather bot.
2. Get bot token of created bot and insert it into script.
3. Send any message to your bot.
4. Excute command:
   `curl -sS https://api.telegram.org/bot{BOT_TOKEN_HERE}/getUpdates | jq '.result[0].message.chat.id'`
to receive chat id value.
5. Insert chat id value into script.
6. You're awesome and the script is ready to use.
7. Check any url with script: ./siteheartbeat.sh -u https://www.google.com
