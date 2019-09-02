# xpend-rails-api
xpend is an app for people to track expenses.  
Using our brains to track our expenses can be quite a tedious task, or even, forgotten!  
This app aims to solve that!

## How to run the backend locally.
- Make sure that you have `ruby 2.6.3`. If you don't, but you have [RVM](https://rvm.io/), simply run:  
  `rvm install ruby-2.6.3`
  
- `bundle install`
- `rails s` and you're good to go!

## How to update Swagger documentation
```ruby
RAILS_ENV=test rake rswag:specs:swaggerize
```
