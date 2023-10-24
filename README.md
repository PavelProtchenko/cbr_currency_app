# README

This README would normally document whatever steps are necessary to get the
application up and running.

Backend setup:

* bundle install
* setup your database connection in database.yml (better use postrgresql)
* bundle exec rake db:create
* bundle exec rake db:migrate
* bundle exec rake db:seed
* bundle exec sidekiq -C config/sidekiq.yml

Frontend setup:

* cd frontend
* npm i
* npm run start
