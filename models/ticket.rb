#Codeclan Week 03 Day 05 Homework
# Codeclan Cinema
# Relational Databases and Ruby
# Ticket Class



require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id,:film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id'] #bring a last name for sorting purposes
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id, film_id
    )
    VALUES
    (
      $1,$2
    )
    RETURNING id"
    values = [@customer_id,@film_id]
    ticket = SqlRunner.run( sql, values ).first
    @id = ticket['id'].to_i
  end

  def update()

    sql = "UPDATE tickets SET
    (
      customer_id,film_id
    )
    =
    (
      $1,$2
    )
    WHERE id = $3"
    values = [@customer_id,@film_id,@id]
    ticket = SqlRunner.run( sql, values ).first

  end

  def tickets
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN tickets ON tickets.id = tickets.ticket_id
    WHERE tickets.ticket_id = $1;
    "
    values = [@id]
    tickets_arr = SqlRunner.run(sql,values)
    tickets = tickets_arr.map{|ticket| Ticket.new(ticket)}
    return tickets
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    tickets = SqlRunner.run(sql, values)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
    return "Removed"
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql,values)
    ticket_hash = results.first
    ticket = Ticket.new(ticket_hash)
    return ticket
  end

  def self.count_customer(customer) #class method
    sql = "SELECT * FROM tickets where customer_id = $1"
    values = [customer.id]
    results = SqlRunner.run(sql,values)
    count = results.map { |ticket| Ticket.new( ticket ) }
    return "#{count.length} tickets bought by #{customer.first_name} #{customer.last_name}"
  end





end
