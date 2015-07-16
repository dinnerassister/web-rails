== BETA

== Dinner Assister
This is a recipe application to help plan your meals. 


* Ruby version: 2.2
* Rails: 4.2.1

## Set up
### Database
Set up your database.yml file. I am using postgres.


### secrets.yml - Optional
secrets.yml contains api id and key this application use. This is not require to run the app. 


### Mailer - Optional
I use mailer to send password reset or unlock account. You should set it up in development.rb.

## Running test
`rake` runs all the test.
This project is currently using rspec and cabybara. I believe in writing enough test that will let you sleep at night and have confidence when you ship the applicaiton, but not too much that it becomes a nighmare to maintain.