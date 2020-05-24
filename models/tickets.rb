require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :movie_id, :cost


  def initialize( options )
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @customer_id = options['customer_id'].to_i
    @cost = options['cost']
  end

  # Instance method
  def save()
    sql = "INSERT INTO tickets
    (
      movie_id,
      customer_id,
      cost
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@movie_id, @customer_id, @cost]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end


  # return the movie ticketed on this ticket
  def movie()
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [@movie_id]
    pg_result = SqlRunner.run(sql, values)
    movie_hash = pg_result[0]
    movie = movie.new(movie_hash)
    return movie
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    pg_result = SqlRunner.run(sql, values)
    customer_hash = pg_result.first
    customer = customer.new(customer_hash)
    return customer
  end

  # Class methods
  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end
