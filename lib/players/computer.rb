module Players 
    class Computer < Player
        def move(board)
            rand(1..8).to_s
        end
    end
end