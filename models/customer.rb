#Codeclan Week 03 Day 05 Homework
# Codeclan Cinema
# Relational Databases and Ruby
# Customer Class


require_relative('../db/sql_runner')
require('pry')

class Customer

  attr_reader :id
  attr_accessor :first_name,:last_name, :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @funds = options['funds']
    @first_name = options['first_name']
    @last_name = options['last_name'] #bring a last name for sorting purposes
  end

  def save()
    sql = "INSERT INTO customers
    (
      first_name, last_name, funds
    )
    VALUES
    (
      $1,$2,$3
    )
    RETURNING id"
    values = [@first_name,@last_name,@funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def update()

    sql = "UPDATE customers SET
    (
      first_name,last_name, funds
    )
    =
    (
      $1,$2,$3
    )
    WHERE id = $4"
    values = [@first_name,@last_name,@funds,@id]
    customer = SqlRunner.run( sql, values ).first

  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE tickets.customer_id = $1;
    "
    values = [@id]
    customers_arr = SqlRunner.run(sql,values)
    customers = customers_arr.map{|customer| Customer.new(customer)}
    return customers
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM customers WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
    return "Removed"
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql,values)
    customer_hash = results.first
    customer = Customer.new(customer_hash)
    return customer
  end

  def can_afford(film_obj)
    return true if film_obj.price <= funds
  end

  def buy_ticket(film_string)
    film_ary = Film.map_items(Film.all)
    film_obj = film_ary.find{|film| film['title'] == film_string}
    binding.pry
    if self.can_afford(film_obj.price) == true
      @funds -= film.price
      new_ticket = Ticket.new(
        {
          'customer_id' => self.id,
          'film_id'=> film.id}
        )
      else
        return nil
      end
    end


  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films = SqlRunner.run(sql,values)  #pull film from PG array-type object
    results = films.map {|film| Film.new(film)}
    return results
  end

  def self.films(customer_id_int) #Was a PITA creating a new instance of films/tickets every time
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets ON tickets.film_id = films.id
    WHERE tickets.customer_id = $1"
    values = [customer_id_int] #class method so accept a parameter
    films = SqlRunner.run(sql,values)
    results = films.map {|film| Film.new(film)}
    return results
  end

  def self.request_film_data

  end
  
  def self.map_items(customer_data) #this move allows you to pull the records out as objects in an array
    result_ary = data.map{|customer| Customer.new(customer)}
    return result
  end
end
