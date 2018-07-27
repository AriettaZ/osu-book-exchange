# Project 6
### Ruby on Rails Project
### 1. [Overview](#overview)
### 2. [Setup](#setup)
### 3. [Workflow](#workflow)
### 4. [Functionality](#functionality)
### 5. [Team](#team)
### 6. [Individual Contributions](#individual-contributions)

***

### Overview
#### Problems: Buying and selling textbooks takes too much time and effort.
Textbooks often have to be rented or sold to large organizations for a loss.
These organizations turn around and upcharge the book for the next group of students.
Waiting for a book by mail may not be an option.
Students need a single source to communicate and exchange their books with one another.

#### Solution: The MAGiC team has created the OSU Textbook Exchange web application.

Our web application features intuitive account registration and post creation.
Posts may be book requests or offers. These posts can be easily searched, sorted, and bookmarked.
Students can message one another and create contracts.
Order issues can be resolved by admin users.
Automated mailing updates users on the status of their orders.

***

### Setup

#### Setting it all up!
Follow the installation setup for the Textbook Exchange server.

##### Step One: Install Required Gems
```
bundle install
```
##### Step Two: Install Oracle JRE 8
```
sudo add-apt-repository ppa:webupd8team/java
sudo apt update
sudo apt install oracle-java8-installer
sudo apt-get install oracle-java8-installer
```
Make sure to restart your computer or the next steps may fail.

##### Step Three: Set up sunspot solr
```
rails generate sunspot_rails:install
bundle exec rake sunspot:solr:start
```
##### Step Four: Set up database
```
rails db:migrate
rails db:setup
```
##### Step Five: Run server
```
rails server
```

##### Optional Step: Set up the mailer
Store your email address and password in config/application.yml file.
```
GMAIL_USERNAME: 'example@gmail.com'
GMAIL_PASSWORD: 'examplePassword'
```
Then go to app/mailers/application_mailer.rb to edit default emailer sender:
```
default from: 'example@gmail.com'
```

Some features like email notifications will not work unless the mailer has been configured.

##### Testing
To test models, run the following commands.
```
RAILS_ENV=test bundle exec rake sunspot:solr:start
rails test:models
```
Note that all other sunspot:solr processes must be killed or the database will be
locked.

***

### Workflow


***

### Functionality
##### Authentication
- Register
- Login
- Log out
- Forget password



##### Authorization
- Admin Management Center: posts, orders, books and contracts data tables
- Besides admin, only the creator of post/order/contract can edit/delete

##### Automated Jobs
- Periodically update the database and notify users by email
- i.e. Order's status will change to *completed* after 3 days of the meeting day if user hasn't marked it as *completed*
- i.e. Contract will expire after the date set by user
- i.e. User will receive email notifications on post/contract/order changes


##### Live Book Search
- Pass isbn or title query to search and retrieve Google Books API
- Examples on *Offer Book* and *Request Book* pages

##### Post Search and Filter
- Handle database indexing and partial matches using Sunspot
- Examples on *Home*, *About OSU Book Exchange* and *Search Post* Pages


#### Messaging
- Instant messaging between buyer and seller/ users and admin using Ajax
- Examples on *my messages* page under profile, *start an conversation* form accessed from posts and *chat with admin* on contact us page

***

### Team
* Overall Project Manager: Mike Lin
* Coding Manager: Gail Chen
* Testing Manager: Channing Jacobs
* Documentation: Ariel Zhu

***

### Individual Contributions
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
  * Book controller and views
  * Set up all initial models
  * Authentication
  * Authorization
  * Admin pages
  * Google Book API
  * ER diagram
