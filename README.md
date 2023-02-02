# README

Instaclone: This app is similar to Instagram. Helps me learn Ruby on Rails

![Preview](preview.png)

Live - https://instaclone.dipenchauhan.com

## Model

Generated by Rails ERD. Run rails erd to regenerate (must have graphviz).
![ERD Diagram](erd.png)

## Versions

- ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]
- Rails 7.0.4

## Features

- Nested Comments (comments with responses using JS)
- Cache Counters for number of likes, followers and comments
- Turbo create, update, destroy actions for like, follow and comments
- Bootstrap CSS
- Stimulus for resizing textarea to fit the size of the text

## TODO

- Omniauth
- Feed Page
- Profile Page
- Post Show Page
- Comments
- Following
- Likes

#### Done

- Devise Setup
- Login/edit profile (devise) views
- Return to Top button

## Standard Steps in all my apps:

- Add gems:

```ruby
gem "sassc-rails"
gem "image_processing", "~> 1.2"
gem "devise"
gem "rails-erd"

# In development group:
gem "annotate"
gem "faker"
# Preview email in the default browser instead of sending it.
gem "letter_opener"
# Format ERB Files
gem "erb-formatter"
```

- Rails erd:

  - Add .erdconfig file

  ```sh
  echo "attributes: content,foreign_key" > .erdconfig
  echo "filetype: png" >> .erdconfig
  ```

  - Run `bundle exec rails g erd:install`

- Annotate

  - Create routes.rake file:

  ```sh
  curl -LJ --output lib/tasks/routes.rake https://github.com/overdrivemachines/dipen_chauhan/raw/master/lib/tasks/routes.rake
  ```

  - Run `rails g annotate:install`

- Add Bootstrap - https://dev.to/overdrivemachines/add-bootstrap-5-and-font-awesome-6-to-rails-7-31b3

## Deployment instructions

```sh
ssh deploy@dipenchauhan.com
# Create postgres user for this app
sudo -u postgres createuser -s instaclone -P
# Create DB:
rails db:create
```

- Add the above password in credentials on development server:

```sh
EDITOR="code --wait" rails credentials:edit
```

```
database_production:
  password: <your_password>
```

- Update database.yml:

```
production:
  <<: *default
  database: instaclone_production
  username: instaclone
  password: <%= Rails.application.credentials.database_production[:password] %>
```

- Install the local gems while preventing the installation of production gems

```sh
bundle config set --local without 'production'
bundle install
bundle lock --add-platform x86_64-linux
```

- (Optional) Reset DB: `rails db:migrate:reset`

## References

- PostgreSQL Setup
  - https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-20-04
  - https://www.youtube.com/watch?v=5QUTfcO7BEw
- Email Validation - https://mailtrap.io/blog/rails-email-validation/
- /:username - https://angelos.dev/2020/04/slash-username-urls-in-rails/
- Resize Images
  - https://dev.to/mikerogers0/resize-images-with-active-storage-in-rails-481n
  - https://www.bigbinary.com/blog/rails-7-adds-ability-to-use-predefined-variants
  - https://www.youtube.com/watch?v=1cw6qO1EYGw
- Save and Delete button - https://dev.to/konnorrogers/escaping-the-traditional-rails-form-4c4o
- Devise User Model with Roles - https://btihen.me/post_ruby_rails/rails_devise_users_namespaced/
- Counter Caches
  - https://blog.appsignal.com/2018/06/19/activerecords-counter-cache.html
  - https://guides.rubyonrails.org/association_basics.html#options-for-belongs-to-counter-cache
- Rake Tasks
  - https://www.seancdavis.com/posts/how-to-write-a-custom-rake-task/
- How to check if a record exists:
  - present? => 2892.7 ms
  - any? => 400.9 ms
  - empty? => 403.9 ms
  - exists? => 1.1 ms
  - https://semaphoreci.com/blog/2017/03/14/faster-rails-how-to-check-if-a-record-exists.html
- Adjust text area hight - https://awik.io/adjust-textarea-height-while-typing-to-fit-content-javascript/
- Iterate through HTMLCollection - https://webcodespace.com/how-to-addeventlistener-to-a-list-of-html-elements-in-javascript/
- Stimulus in Rails 7 - https://dev.to/bhumi/stimulus-rails-7-tutorial-5a6a
- Turbo in Rails 7 - https://blog.corsego.com/turbo-hotwire-CRUD
- JS Naming convetions - https://www.syncfusion.com/blogs/post/10-javascript-naming-conventions-every-developer-should-know.aspx
- Polymorphic likes - https://medium.com/@jamesreed3050/setting-up-polymorphic-likes-in-rails-7d8be2e01c12
- Followers
  - https://www.devwalks.com/lets-build-instagram-with-ruby-on-rails-part-6-follow-all-the-people/
  - Includes - https://medium.com/@pdiba/creating-a-follower-system-in-rails-38b7d59d63ac
