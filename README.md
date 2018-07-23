# Project 6
### Ruby on Rails Project

### Roles
* Overall Project Manager:
* Coding Manager:
* Testing Manager:
* Documentation:

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

#### Setup
##### Install Required Gems
bundle install
##### Install Oracle JRE 8
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
sudo apt-get install oracle-java8-installer
Make sure to restart your computer or the next steps may fail.
##### Set up sunspot solr
rails generate sunspot_rails:install
bundle exec rake sunspot:solr:start
##### Set up database
rails db:migrate
rails db:setup
##### Run server
rails server
