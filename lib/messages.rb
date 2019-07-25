class Message
  attr_accessor :body, :header, :board_id
  attr_reader :id, :timestamp
  @@messages = {}
  @@total_rows = 0
  
  def initialize (attributes)
  @id = id || @@total_rows += 1
  @timestamp = Time.now
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

 def save
   @@messages[self.id] = self
 end
end
