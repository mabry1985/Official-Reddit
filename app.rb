require('sinatra')
require('sinatra/reloader')
require('./lib/boards')
require('./lib/messages')
require('pry')
also_reload('lib/**/*.rb')

get ('/') do
  @boards = Board.all
  erb(:index)
end

get ('/boards/new') do
  erb(:new_board)
end

post ('/new_board') do
  title = params[:title]
  board = Board.new({:title => title})
  board.save()
  redirect to ('/')
end

get ('/boards/:id') do
  @messages = Message.all
  @board = Board.find(params[:id].to_i)
  @messages = Message.find_by_board(:id)
  erb(:board)
end

post ('/newest/:id') do
  @messages = Message.sort_time
  @board = Board.find(params[:id].to_i)
  # @messages = Message.find_by_board(:id)
  erb(:board)
end

post ('/oldest/:id') do
  @messages = Message.unsort_time
  @board = Board.find(params[:id].to_i)
  # @messages = Message.find_by_board(:id)
  erb(:board)
end
post ('/boards/:id') do
  header = params[:message_header]
  body = params[:body]
  @board = Board.find(params[:id].to_i)
  @message = Message.new ({:header => header, :body => body, :board_id => @board.id})
  @message.save()
  erb (:board)
end
