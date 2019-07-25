require 'pry'

class Message
  @@count = 0
  attr_accessor :body, :header, :board_id
  attr_reader :id, :timestamp
  @@messages = {}
  @@total_rows = 0

  def initialize (attributes)
    @id = id || @@total_rows += 1
    @timestamp = Time.now
    @header = attributes.fetch(:header)
    @body = attributes.fetch(:body)
    @board_id = attributes.fetch(:board_id)
  end

  def board
    Board.find(self.board.id)
  end

  def self.find_by_board(board_id)
    messages = []
    @@messages.values.each do |message|
      if message.board_id == board_id
        messages.push(message)
      end
    end
    messages
  end

  def self.all()
    @@messages.values()
  end

 def save
   @@messages[self.id] = self
 end

 def self.sort_time
   temp_messages = @@messages.sort_by{|key, value| value.timestamp}
   temp_messages.reverse!
   @@count += 1
   @@messages = Hash[temp_messages.map { |key, values| [key, values]}]
 end

 def self.unsort_time
   temp_messages = @@messages.sort_by{|key, value| value.timestamp}

   @@count += 1
   @@messages = Hash[temp_messages.map { |key, values| [key, values]}]
 end

 def self.q
   @@count
 end
 def self.w
   @@count = 0
 end
end
