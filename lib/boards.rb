class Board
  attr_accessor :message, :title
  attr_reader :id, :timestamp

  @@boards = {}
  @@total_rows = 0

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @messages = {}
    @timestamp = Time.now
    @id = id || @@total_rows += 1
  end


  def messages
    Message.find_by_board(self.id)
  end

  def save
    @@boards[self.id] = self
  end

  def self.all()
    @@boards.values()
  end

  def self.find(id)
    @@boards[id]
  end

end
