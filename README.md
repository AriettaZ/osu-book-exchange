# Project 6
### Ruby on Rails Project

### Roles
* Overall Project Manager: Mike Lin
* Coding Manager: Gail Chen
* Testing Manager: Channing Jacobs
* Documentation: Ariel Zhu

### Contributions
* Mike
  * Messaging controller and views
  * Search controller and views
  * Contacts controller and views
  * All pages under the Pages controller and their HTML and CSS
  * System testing and bug fixes
* Gail
  * Contracts controller and views
  * Orders controller and views
  * Active Job
  * Mailer helper
  * Routes diagram
* Channing
  * Bookmarks model
  * Dashboard and about HTML and CSS
  * Model validations and testing
  * AJAX controller and views
  * ER diagram and slide layout
  * README
* Ariel
  * Post controller and views
  * Set up all initial models
  * Authentication
  * Authorization
  * Admin pages
  * Google Book API
  * ER diagram

#### Setting it all up!
##### Install Required Gems
```
bundle install
```
##### Install Oracle JRE 8
```
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
sudo apt-get install oracle-java8-installer
```
Make sure to restart your computer or the next steps may fail.
##### Set up sunspot solr
```
rails generate sunspot_rails:install
bundle exec rake sunspot:solr:start
```
##### Set up database
```
rails db:migrate
rails db:setup
```
##### Run server
```
rails server
```
#####Set up email notification
Store your email address and password in config/application.yml file.
```
GMAIL_USERNAME: 'example@gmail.com'
GMAIL_PASSWORD: 'examplePassword'
```
Then go to app/mailers/application_mailer.rb to edit default emailer sender:
```
default from: 'example@gmail.com'
```
##### Testing
To test models, run the following commands.
```
RAILS_ENV=test bundle exec rake sunspot:solr:start
rails test:models
```
Note that all other sunspot:solr processes must be killed or the database will be
locked.
