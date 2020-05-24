require_relative('../db/sql_runner')

class Movie

attr_reader :id, :name, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @price = options['price']
  end

  def customers()
    sql = "SELECT customers.*
           FROM customers
           INNER JOIN tickets
           ON tickets.star_id = customers.id
           WHERE movie_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    star = results.map {|star| Star.new(star)}
    return star
  end

  def update()
    sql = "UPDATE movies
           SET
    (
          name,
          price
    ) =
    (
          $1, $2
    )
    WHERE id = $3"
    values = [@name, @price, @id]
    SqlRunner.run(sql, values)
  end

  def save()
    sql = "INSERT INTO movies
      (
          name,
          price
      ) VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@name, @price]
      returned_array = SqlRunner.run(sql, values)
      movie_hash = returned_array[0]
      @id = movie_hash['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM movies"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM movies"
      movies = SqlRunner.run(sql)
      return movies.map{|person| Movie.new(person)}
    end

  end
