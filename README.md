# Rails (3.2.15) base application

This is a base app named 'Site'.

## This has:

- **Public**: The home page and login page
- **BackOffice**: Separed space with a users CRUD. The *bo* is the short for BackOffice


## Gems

- **authlogic**:      Used for authenticaton
- **will_paginate**:  For paginated queries (used in users list)


## Changes from empty Rails (3.2.15) app:

- **Models**: Add ```user``` and ```user_session```
- **Controllers**: Add ```home_controller```, ```user_sessions_controller``` and a ***bo*** namespace with ```bo/users_controller``` and ```bo/base_controller```, the ```base_controller``` is the controller that all controllers inside *bo* namespace must be extend, this ```base_controller``` is used to guarantee that only authenticated users can access and if you like for other common things.
- **Views**: The necessary for controllers but with two layouts, one for public, ```applicaiton``` and other used for ```bo/base_controller```, the ```application_bo```
- **Assets**: We separate the assets from public and *bo*, the ```application.js``` is only for public and the ```bo/applicaton.js``` is used only for *bo*. This is because in layouts application we use ```application.js``` and in ```application_bo``` we use ```bo/application.js```. For work with this we change ```require_tree .``` for ```require_directory .``` in ```application.js``` and ```bo/application.js```. This means that if you add a new folder this aren't included by default, you need add the line ```require_directory <dir_name>```. This also applies to the CSS.
- **Routes**: Add routes for ```home```, ```usser_sessions```, ```bo/users``` and match ```users_sessions#new``` and ```#destroy``` with ```login``` and ```logout``` 
- **Migrations**: Create users table, note: we don't use the 'login' column of authlogic
- **Seed**: Add default user

## Run the example:

- Create database:
  - ```$ bundle exec rake db:create```
- Mirate: 
  - ```$ bundle exec rake db:migrate```
- Run seed
  - ```$ bundle exec rake db:seed```
- Run server
  - ```$ bundle exec rails s```