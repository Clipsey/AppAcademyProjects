class Board

    attr_reader :size
    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @grid.each { |row| p row }
    end

    def initialize(size)
        @size = size
        @grid = Array.new(size) {Array.new(size)}
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @grid[row][col] = val
    end

    def complete_row?(mark)
        @grid.each do |row|
            if row.all? {|ele| ele == mark}
                return true
            end 
        end
        return false
    end

    def complete_col?(mark)
        col = 0
        while col < @grid.length
            if (0...@grid.length).all? {|i| @grid[i][col] == mark }
            return true
            end
            col += 1
        end
        return false
    end

    def complete_diag?(mark)
        if (0..@grid.length - 1).all? {|i| @grid[i][i] == mark}
            return true
        elsif (0..@grid.length - 1).all? {|i| @grid[@grid.length - 1 - i][i] == mark}
            return true
        end
        return false
        #[ X  X  0,2]
        #[ 0  0  1,2]
        #[ 2,0  2,1  X]

        #[0,0  0  2,0]
        #[X  1,1, 1,2]
        
    end

    def winner?(mark)
        if self.complete_diag?(mark) || self.complete_col?(mark) || self.complete_row?(mark)
            return true
        end
        return false
    end

end
