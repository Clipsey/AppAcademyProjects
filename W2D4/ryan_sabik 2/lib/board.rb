class Board
    attr_reader :size

    def initialize(size)
        @size = size
        @grid = Array.new(size) {Array.new(size)}
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, mark)
        @grid[pos[0]][pos[1]] = mark
    end

    def complete_row?(mark)
        @grid.any? {|row| row.all? {|ele| ele == mark}}
    end

    def complete_col?(mark)
        (0...size).each do |col|
            return true if (0...size).all? {|row| @grid[row][col] == mark}
        end
        false
    end

    def complete_diag?(mark)
        #diags == 0,0...n,n || 0,n -> 1,n-1 ... n-1,1 -> n,0
        
        diag_1_result = (0...size).all? {|i| mark == @grid[i][i]}
        diag_2_result = (0...size).all? {|i| mark == @grid[i][size-1-i]}
        diag_1_result || diag_2_result
    end

    def winner?(mark)
        complete_row?(mark) || complete_col?(mark) || complete_diag?(mark)
    end

    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @grid.each { |row| p row }
    end
end
