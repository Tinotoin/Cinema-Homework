require_relative('../db/sql_runner')

class Customer

attr_reader :id, :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def fee()
    sql = "SELECT movies.*, tickets.*
           FROM movie
           INNER JOIN tickets
           ON movies.id = tickets.movie_id"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |result| "#{result['customer']}: #{result['funds']}" }
  end

  def update()
    sql = "UPDATE customers
           SET
    (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def movies()
    sql = "SELECT movies.*
           FROM movies
           INNER JOIN tickets
           ON tickets.movie_id = movies.id
           WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    movie = results.map {|movie| Movie.new(movie)}
    return movie
  end

####

  # def funds
  #   sql = "SELECT * FROM "
  #
  # def funds()
  #   funds = self.

  def save()
    sql = "INSERT INTO customers
      (
      name, funds
      ) VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@name, @funds]
      returned_array = SqlRunner.run(sql, values)
      customer_hash = returned_array[0]
      @id = customer_hash['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM customers"
      customers = SqlRunner.run(sql)
      return customers.map{|person| customer.new(person)}
    end

  end
