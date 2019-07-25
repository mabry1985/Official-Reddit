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
  @board = Board.find(params[:id].to_i)
  @messages = Message.find_by_board(1)
  erb(:board)
end

post ('/boards/:id') do
  header = params[:message_header]
  body = params[:body]
  @board = Board.find(params[:id].to_i)
  @messages = Message.find_by_board(1)
  @message = Message.new ({:header => header, :body => body, :board_id => @board.id})
  @message.save()
  binding.pry
  redirect ('/boards/:id')
end
