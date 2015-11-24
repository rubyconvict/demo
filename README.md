## Demo

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Installation
---------------

* bundle install
* edit config/database.yml
* cp config/application.yml.example config/application.yml
* edit config/application.yml
* bundle exec rake db:migrate db:seed
* bundle exec rails s

Run websocket server in other window
---------------
* cd socky/
* bundle install
* ws_password="password" thin -R config.ru -p3001 start

heroku
---------------

bundle exec figaro heroku:set -e production
