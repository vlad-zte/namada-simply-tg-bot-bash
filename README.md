I made a simple telegram bot for Namada. In the bash. Do you want the same? Then let's go!

Я сделал простого телеграм бота для Намады. В баше. Хочешь такого же? Тогда погнали!


![Screenshot_2024-03-04_19-33-47](https://github.com/vlad-zte/namada-simply-tg-bot-bash/assets/112316072/a9a6419c-6d6b-4af4-9ae4-5090031c7a71)

First. We need BotFather.


Первое. Нам нужен BotFather. 


To activate the chatbot setup service, open Telegram, type @BotFather in the search bar, select the bot and click “Launch”.
To create a Telegram bot via BotFather, select the /newbot command. BotFather will ask you to set up a title and name for the bot.
There are no restrictions or special requirements for the name and title. However, the name must be strictly in Latin with the ending bot/Bot.
Please note: the bot name must be unique. If you enter a name that already exists, BotFather will ask you to select a different name.
When creating a bot, BotFather generates a unique API token - the key to your chatbot. Let's save it. We will need it later. And we don’t distribute it publicly. This key is private.


Чтобы активировать сервис настройки чат-ботов, открываем Telegram, вбиваем в строке поиска @BotFather, выбираем бота и нажимаем «Запустить».
Чтобы создать Telegram-бот через BotFather, выбираем команду /newbot. BotFather попросит настроить название и имя для бота. 
Ограничений и особых требований для имени и названия нет. Однако имя должно быть строго на латинице с окончанием bot/Bot. 
Обратите внимание: имя бота должно быть уникальным. Если вы введёте наименование, которое уже есть, BotFather попросит вас выбрать другое имя.
При создании бота BotFather генерирует уникальный API токен — ключ к вашему чат-боту. Сохраняем его. Он нам понадобится в дальнейшем. И не распостраняем в паблик. Этот ключ приватный. 


Ok, we have a bot. Now we create a public group in Telegram. The name is again any name. But unique. I'm creating a channel @vlad_zte_namada. We add our bot to the group as a user. But with administrator rights. He must have permission to add messages.


Ок, бот у нас есть. Теперь создаем публичную группу в телеграм. Имя название опять таки любое. Но уникальное. Я создаю канал @vlad_zte_namada. Добавляем нашего бота в группу как пользователя. Но с правами администратора. Он должен иметь права добавлять сообщения.


Ok, we created a group. Now comes the fun part.


Ок, создали группу. Теперь самое интересное.


Let's go to the console on the server. And run the following commands there:


Идем  в консоль на сервере. И выполняем там следующие команды:


BOT_TOKEN='****'


here we write our bot API, which was given to us when creating the bot.


здесь пишем наш API бота, который нам дали при создании бота.


CHANNEL_ID="@vlad_zte_namada"

 
Here is the name of the channel in the TG that we created for ourselves, and where we added the bot as an admin.


Здесь то имя канала в ТГ , который мы создали себе, и куда добавили бота как админа.


Getting the channel ID


Получаем ID канала


curl -s https://api.telegram.org/bot${BOT_TOKEN}/getChat?chat_id=$CHANNEL_ID


The answer will be like


Ответ будет вида


{"ok":true,"result":{"id":-1001*****,"title":"vlad-zte-namada","type":"channel","invite_link":"https://t.me/*****","has_visible_history":true,"accent_color_id":3}}


From here we only need the id. 13 digits. I will hide my bot ID and API behind asterisks, well, just in case, you never know, privacy, after all..


Нам отсюда нужен только id. 13 цифр. Я спрячу свой ID и API бота за звездочками, ну, на всякий случай, мало ли что, приватность , все же.. 


That's it, now we make the channel private in the settings. And once again we check that the bot can write to the channel using the same command, just redefine the channel ID


Все, теперь делаем в настройках канал приватным. И еще раз проверяем, что бот может писать в канал, той же командой, только переопределим ID канала


CHANNEL_ID="-1001*****" 


do curl again. You should receive the same answer as before.


опять делаем curl. Должны получить такой же ответ, как и до этого.


curl -s https://api.telegram.org/bot${BOT_TOKEN}/getChat?chat_id=$CHANNEL_ID


Ok, 50% done.


Ок, 50% сделано.


Now let's create the script. For me it's send.sh . We copy the contents of the send.sh file from this repository into it. Don’t forget to redefine variables from the bot API inside the script. And telegram channel ID.


Теперь создаем скрипт. У меня это send.sh . Копируем в него содержимое файла send.sh из этого репозитария. Не забываем переопределить внутри скрипта переменные с API бота. И ID канала телеграм.


Making the file executable.


Делаем файл выполняемым. 


chmod +x send.sh


Run! 


Запускаем! 


./send.sh


And if everything was done correctly, we will receive a message in telegram. That's it, we're great!


И если все сделали правильно, то получим сообщение в телеграм. Все, мы молодцы!
