# Project 6 Ruby on Rails Project
### 1. [Overview](#overview)
### 2. [Set Up](#set-up)
### 3. [Workflow](#workflow)
### 4. [Functionality](#functionality)
* **[Authentication](#authentication)**
* **[Authorization](#authorization)**
* **[Automated Jobs & Mailer](#automated-jobs--mailer)**
* **[Live Book Search](#live-book-search)**
* **[Post Search and Filter](#post-search-and-filter)**
* **[Realtime Messaging](#realtime-messaging)**
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

### Set Up

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
If there is a solr folder, delete this folder by
```
rm -rvf solr
```
Then set up the sunspot solr
```
rails generate sunspot_rails:install
bundle exec rake sunspot:solr:start
```
##### Step Four: Set up database
```
rails db:migrate
rails db:setup
```

##### Step Five: Set up the mailer
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

##### Step Six: Run server
```
rake sunspot:solr:reindex
rails server
```
Our website is deployed already. Please visit https://osu-book-exchange.herokuapp.com.

##### Testing
To test models, run the following commands.
```
RAILS_ENV=test bundle exec rake sunspot:solr:start
rails test:models
```
Note that all other sunspot:solr processes must be killed or the database will be
locked.

##### Accounts
- User account
  - Sign up on register page for a user account
  - Or use test account
    - username: user@osu.edu
    - password: password
    
- Admin account
  - username: admin@osu.edu
  - password: password

***

### Data Storage
The team uses SQLite for data storage.
#### Models:
- Bookmarks
- Books
- Users
- Contracts
- Images
- Orders
- Posts

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/ER%20Diagram.png" width="900">


***

### Workflow
<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/ce376ae5dbc95d292a38e7617d471717bb97abb5/app/assets/images/workflow.png" width="900">

***

### Functionality
### Authentication
- Sign up
- Login
- Log out
- Forget password

Example sign up Page:

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/sign_up_form.png" width="900">

### Authorization
- Admin Management Center: posts, orders, books and contracts data tables
- Besides admin, only the creator of post/order/contract can edit/delete

Example post records table for admin user:

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/admin_post_page.png" width="900" alt="admin post record">

#### Automated Jobs & Mailer
- Periodically update the database and notify users by email
- i.e. Order's status will be changed to *completed* after 3 days of the meeting day if user hasn't marked it as *completed*
- i.e. Contract's status will be changed to *declined* when it is expired and has status "waiting"
- i.e. User will receive email notifications on contract/order status changes

Example Contract expire and email notification:

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/expired_contract.png" width="900" alt="expired contract">

### Live Book Search
- Pass isbn or title query to search and retrieve Google Books API
- Examples on *Offer Book* and *Request Book* pages

Example search book by title result:

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/title_book_search.png" width="900" alt="by title">


Example search book by ISBN result:

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/isbn_book_search.png" width="900" alt="by isbn">

### Post Search and Filter
- Handle database indexing and partial matches using Sunspot
- Examples on *Home*, *About OSU Book Exchange* and *Search Post* Pages

Search and filter Post

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/post_search_page.png" width="900" alt="post search and filter">

### Realtime Messaging
- Instant messaging between buyer and seller/ users and admin using Ajax
- Examples on *my messages* page under profile, *start an conversation* form accessed from posts and *chat with admin* on contact us page

<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/adc44c5b6d920a36c1330c2a02c9dc7b447ad5f4/app/assets/images/messaging_system.png"  width="900" alt="expired contract">

***

### Team
<img src="https://github.com/cse3901-osu-2018su/MAG-C-Project-6/blob/a33314b306c6f996a6d1428b33db1edf4a88ae5b/app/assets/images/6631528842598_.pic.jpg" width="400">

| Role|Team Member|
| ------------- |-------------|
| Overall Project Manager| Mike Lin |
|Coding Manager| Gail Chen |
|Testing Manager| Channing Jacobs |
|Documentation Manager| Ariel Zhu |

*Contact Us: osu.magic.team@gmail.com*

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
  * Dashboard - My Contracts & My Orders
  * Active Job
  * Mailer helper
  * Workflow / State Change Diagram
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
  * README
