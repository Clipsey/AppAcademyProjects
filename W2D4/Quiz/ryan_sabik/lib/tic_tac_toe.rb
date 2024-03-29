require_relative 'board'
require_relative 'player'

class TicTacToe
    def initialize(size=3)
        @board = Board.new(size)
        @player_1 = Player.new(:X)
        @player_2 = Player.new(:O)
        @current_player = @player_1
    end

    def switch_players!
        case @current_player
        when @player_1          then @current_player = @player_2
        when @player_2          then @current_player = @player_1
        end
    end

    # This TicTacToe#play method is given for free and does not need to be modified
    # It is used to make your game playable.
    def play
        until @board.winner?(:X) || @board.winner?(:O)
            p "#{@current_player.mark}'s turn"
            @board.print
            pos = @current_player.get_position
            @board[pos] = @current_player.mark
            self.switch_players!
        end

        @board.print
        self.switch_players!
        p "#{@current_player.mark} has won!"
    end
end
