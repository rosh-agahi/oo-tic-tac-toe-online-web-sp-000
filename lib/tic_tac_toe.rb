class TicTacToe
  
  attr_accessor :board, :user_input, :occupied, :index, :player
  
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def turn_count
    occupied = 0
    turn_counter = @board.each do |position|
      if position == "X" || position == "O"
      occupied += 1
      end
      end
    occupied
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def move(index, player)
    @board[index] = player
  end

  def position_taken?(index)
    if @board[index] == " " || @board[index] == "" || @board[index] == nil
      return false
      else 
      return true
    end
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts 'Please enter 1-9:'
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      token = current_player
      move(index, token)
    else
      turn
    end
    display_board
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end
  end

# Game Outcomes: Win / Draw

WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Right column
  [1,4,7], # Middle column
  [2,5,8], # Left column
  [0,4,8], # Diagonal 1
  [2,4,6]  # Diagonal 2
  ]
  
  def won?
    WIN_COMBINATIONS.any? do |combo|
      if position_taken?(combo[0]) &&
        @board[combo[0]] == @board[combo[1]] &&
        @board[combo[1]] == @board[combo[2]]
        return combo
      end
    end
  end

  def full?
    @board.all?{|character| character == "X" || character == "O"}
  end
  
  def draw?
    full? && !won?
  end
  
  def over?
    draw? || won? || full?
  end
  
  def winner
    if winning_combo = won?
      @board[winning_combo.first]
    end
  end
  
end