class Board

    attr_reader :size

    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n * n
    end

    def [](pair)
        @grid[pair[0]][pair[1]]
    end

    def []=(pos, val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        @grid.inject(0) {|acc, row| acc + row.count {|val| val == :S}}
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H
            puts 'you sunk my battleship!'
            true
        else
            self[pos] = :X
            false
        end
    end

    def place_random_ships
        length = @grid.length
        totalships = @size/4
        (0...totalships).each do |i|
            x, y = rand(length), rand(length)
            while self[[x, y]] == :S
                x, y = rand(length), rand(length)
            end
            self[[x, y]]= :S
        end
    end

    def hidden_ships_grid
        hidden_grid = @grid.map { |row| row.clone }
        hidden_grid.each do |row|
            row.map! { |ele| ele == :S ? :N : ele }
        end
        hidden_grid
    end

    def self.print_grid(grid)
        grid.each { |row| puts row.join(" ")}
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
