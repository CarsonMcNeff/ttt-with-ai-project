class Game 
    attr_accessor :board, :player_1, :player_2
    WIN_COMBINATIONS =  [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    def initialize(player_1 = Players::Human.new("X"),player_2 = Players::Human.new("O"),board = Board.new)
        @player_1 = player_1
        @player_2 = player_2 
        @board = board
    end

    def current_player
        board.cells.count("X") > board.cells.count("O") ? player_2 : player_1
    end

    def won?
        WIN_COMBINATIONS.detect do |comb|
            board.cells.values_at(comb[0],comb[1],comb[2]).uniq.size <= 1 && board.cells[comb[0]] != " "
        end
    end

    def draw?
        board.full? && !won?
    end

    def over? 
        draw? || won?
    end

    def winner
        won? ? board.cells[won?[0]] : nil
    end

    def turn
        cur_play = current_player
        cur_move = cur_play.move(board)
        if !board.valid_move?(cur_move)
            turn
        else  
            board.update(cur_move,cur_play)
            board.display
        end
    end

    def play  
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end