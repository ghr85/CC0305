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

  def request_film_data(film_string)
    sql = "SELECT * FROM films WHERE title = $1"
    values = [film_string]
    films = SqlRunner.run(sql,values)
    result = films.map{|film| Film.new(film)}[0] #YOU HAVE TO ACCESS THE ARRAY TO USE IT!
    return result
  end

  def buy_ticket(film_string) #Wow! This was tough.
    film_obj = self.request_film_data(film_string)
    if film_obj.price.to_i <= @funds # Remember to convert to int
      @funds -= film_obj.price.to_i
      new_ticket = Ticket.new(
        {
          'customer_id' => @id,
          'film_id'=> film_obj.id}
        )
        new_ticket.save
        return "Enjoy #{film_obj.title} #{first_name} "
      else
        return "Sorry #{first_name} you'll need more cash to watch this one."
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




  end
