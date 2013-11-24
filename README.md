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

## Update: Adding Internationalization
Organize the internationalization files:
- Separate the locales for gems in folders
- Add folder with direct yml files for *defaults*, *buttons*, *messges* and *errors*
- Add folder for models with specific subfolders for each model
- Add folder for view with one folder used for *defaults*, and specific subfolders for each *controller*. This support *namespaces*. If the key is not found in the controller it search in the default view's folder.
- Example:

```
+- rails
|   +- es.yml
+- authlogic
|   +- es.yml
+- will_paginate
|   +- es.yml
+- defautls
|   +- en.yml
|   +- es.yml
+- buttons
|   +- en.yml
|   +- es.yml
+- messages
|   +- en.yml
|   +- es.yml
+- errors
|   +- en.yml
|   +- es.yml
+- models
|   +- user
|       +- en.yml
|       +- es.yml
+- views
    +- defaults
    |   +- en.yml
    |   +- es.yml
    +- home
    |   +- en.yml
    |   +- es.yml
    +- user_sessions
    |   +- en.yml
    |   +- es.yml
    +- bo
        +- users
            +- en.yml
            +- es.yml
```

To make this work:
- **Extend I18n**: Add new methods, the extended module are in ```config/initializers/extensions```, and the new methods:
  - **tmodel**: Get human name of model
  - **tattr**: Get human name of model attribute
  - **tbtn**: Buttons 
  - **tmsg**: Messages
  - **terr**: Error messages
- Add new method in `application_helper`.
  - **tview**: Views

For change locale in app:
- Add *I18n.default_locale* in `config/application.rb`
- Force *I18n.available_locales* in `config/application.rb`. The I18n.available_locales is setup by locales in `config/locales` but we overwrite with us custom supported locales.
- Add methods `set_locale` and `extract_locale_from_accept_language_header` and adding `before_filter :set_locale` in `application_controller`, this is for set and store the locale in session memory.


## Run the example:

- Create database:
  - ```$ bundle exec rake db:create```
- Mirate: 
  - ```$ bundle exec rake db:migrate```
- Run seed
  - ```$ bundle exec rake db:seed```
- Run server
  - ```$ bundle exec rails s```