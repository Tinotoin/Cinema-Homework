require_relative('models/customers')
require_relative('models/movies')
require_relative('models/tickets')

require ('pry')

Customer.delete_all()

customer1 = Customer.new({'name' => 'Bruce', 'funds' => 150})
customer1.save()
customer2 = Customer.new({'name' => 'Euphimia', 'funds' => 200})
customer2.save()

movie1 = Movie.new({'name' => 'Ghost', 'price' => 20})
movie1.save()
movie2 = Movie.new({'name' => 'Akira', 'price' => 15})
movie2.save()

ticket1 = Ticket.new({'cost' => 50, 'customer_id' => customer1.id, 'movie_id' => movie1.id})
ticket1.save()
ticket2 = Ticket.new({'cost' => 30, 'customer_id' => customer2.id, 'movie_id' => movie1.id})
ticket2.save()
ticket3 = Ticket.new({'cost' => 50, 'customer_id' => customer2.id, 'movie_id' => movie1.id})
ticket3.save()
ticket4 = Ticket.new({'cost' => 30, 'customer_id' => customer1.id, 'movie_id' => movie2.id})
ticket4.save()

binding.pry
nil
