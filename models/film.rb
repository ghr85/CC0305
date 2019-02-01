#Codeclan Week 03 Day 05 Homework
# Codeclan Cinema
# Relational Databases and Ruby
# Class

require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @price = options['price']
    @title = options['title']
  end

  def save()
    sql = "INSERT INTO films
    (
      title, price
    )
    VALUES
    (
      $1,$2
    )
    RETURNING id"
    values = [@title,@price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def update()

    sql = "UPDATE films SET
    (
      title, price
    )
    =
    (
      $1,$2
    )
    WHERE id = $3"
    values = [@title,@price,@id]
    film = SqlRunner.run( sql, values ).first

  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1;
    "
    values = [@id]
    customers_arr = SqlRunner.run(sql,values)
    customers = customers_arr.map{|customer| Customer.new(customer)}
    return customers
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new( film ) }
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM films WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
    return "Removed"
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql,values)
    film_hash = results.first
    film = Film.new(film_hash)
    return film
  end
  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1
    "
    values = [@id]
    customers = SqlRunner.run(sql,values) #returns PG object
    results = customers.map {|customer| Customer.new(customer)} #converts PG obhect into array of Cust objects
    return results
  end

  def self.customers(film_id_int) #Was a PITA creating a new instance of films/tickets every time
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    values = [film_id_int] #class method so accept a parameter
    customers = SqlRunner.run(sql,values)
    results = customers.map {|customer| Customer.new(customer)}
    return results
  end

  def self.map_items(data) #this move allows you to pull the records out as objects in an array
    result = data.map{|film| Film.new(film)}
    return result
  end


end
