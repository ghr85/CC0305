#Codeclan Week 03 Day 05 Homework
# Codeclan Cinema
# Relational Databases and Ruby
# Class

# Don't worry about an interface for this one just use PRY

require('pry')
require_relative('db/sql_runner')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')
require_relative('models/ticket')


customer_1 = Customer.new({
'first_name'=> 'Charlie',
'last_name'=> 'Baileygates',
'funds'=> 16})

customer_2 = Customer.new({
'first_name'=> 'Hank',
'last_name'=> 'Baileygates',
'funds'=> 8})

film_1 = Film.new({
  'title' => 'Me, Myself, Irene',
  'price' => 4

  })
  film_2 = Film.new({
    'title' => 'Everything is Illuminated',
    'price' => 5

    })
customer_1.save
customer_2.save
film_1.save
film_2.save

customer_1.buy_ticket('Everything is Illuminated')
customer_2.buy_ticket('Everything is Illuminated')
customer_1.buy_ticket('Me, Myself, Irene')



binding.pry
nil
