# README

* Ruby version: 2.5.3

####Database setup
 - `bundle exec rake db:setup`
 - `bundle exec rake db:migrate`
 - `bundle exec rake db:seed`
 
####To Annotate Models
 - `bundle exec annotate`
 
####To lint
 - Run `rubocop --config .rubocop.yml`
 
####To test
 - Run `bundle exec rspec`

####Local dev mode
 - `bundle install`
 - `npm install`
 - `yarn install`
 - `foreman start -f Procfile.dev -p 3000`
 - Visit http://localhost:3000/ (after waiting for the javascript to compile!)
 
####Troubleshooting
 - If you are getting errors around webpack not compiling your ES6 jsx, try:
   
   `npm install react --save`
   
   `npm install babel-preset-es2015`
   
   `npm install babel-preset-react`


####Future Work
 - Implement dropdown or selection inputs for fields with limited choices (e.g. true/false)
 - An "Add more search params" functionality to the webapp
 - Show all related objects to the search objects
    - This one is something I would love to have tackled given more time
    - The design for this was the limiting factor as the backend part is already pretty much set up for it
    - Backend-wise, we'd just need to return `user.organization` or `ticket.submitter`
 - Use jbuilder tempates or presenters
 - Improve speed by selecting specific fields to query/show for each object
 - We could even have implemented elasticsearch for a much faster experience
