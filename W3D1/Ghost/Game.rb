class Game
    attr_reader :player_1, :player_2, :current_player
    def initialize(player_1, player_2)
        @fragment = ""
        @current_player = player_1
        @player_1 = player_1
        @player_2 = player_2
        @dictionary = Hash.new {|h, k| h[k] = ""}
    end

    def play_round
        take_turn(@current_player)
        #if fragment is word > 3
        # return current player wins
        next_player!
    end

    def next_player!
        if @current_player == player_1
            self.current_player = player_2
        else
            self.current_player = player_1
        end
    end

    def take_turn(player)
        char = player.guess
        while !@dictionary.include?(@fragment + char)  
            player.invalid_guess
            char = player.guess
        end
        @fragment += char
    end
    
    

    

end