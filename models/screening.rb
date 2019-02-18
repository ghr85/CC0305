#Codeclan Week 03 Day 05 Homework
# Codeclan Cinema
# Relational Databases and Ruby
# Class

class Screening
  attr_reader :id
  attr_accessor :showtime_string,:film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @showtime_string = options['showtime']
    @film_id = options['film_id']
    @capacity_int = options['capacity']
  end

  def save()
    sql = "INSERT INTO screenings
    (
      showtime, film_id, capacity
    )
    VALUES
    (
      $1,$2,$3
    )
    RETURNING id"
    values = [@showtime_string,@film_id,@capacity_int]
    screening = SqlRunner.run( sql, values ).first
    @id = screening['id'].to_i
  end

  def update()

    sql = "UPDATE screenings SET
    (
      showtime,film_id, capacity
    )
    =
    (
      $1,$2,$3
    )
    WHERE id = $4"
    values = [@showtime_string,@film_id,@capacity_int,@id]
    screening = SqlRunner.run( sql, values ).first

  end


  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    screenings = SqlRunner.run(sql, values)
    result = screenings.map { |screening| Screening.new( screening ) }
    return result
  end

  def self.delete(id) # delete singular instance by looking up table and checking ID?
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
    return "Removed"
  end

  def self.delete_all() #Delete all instances
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.find(id) #search screenings by ID
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql,values)
    screening_hash = results.first
    screening = Screening.new(screening_hash)
    return screening
  end

end #class end
