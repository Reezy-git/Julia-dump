begin
    using CairoMakie
end


begin
    global grid = zeros(20,20)
    global head_pos = [10,10]
    global travel_dir = "UP"
    global snake = [[10,10]]
    global apple_loc = []
    global score = 0
    global moves = 0
    global fig, ax, pl = scatter(1:20)

    function spawn_apple()
        valid = false
        while valid = false
            value = rand(1:20, 2)
            if value not in snake
                global apple_loc = value
                grid()
                valid = true
            end
        end
    end

    function game_end()
        # end the game
    end

    function check_dead()
        if head_pos[1] in [0, 21]
            game_end()
        elseif head_pos[2] in [0, 21]
            game_end()
        elseif head_pos in snake[2:end]
            game_end()
        end
    end

    function move()
        moves += 1
        x, y = head_pos
        if travel_dir == "UP"
            y -= 1 end
        if travel_dir == "LEFT"
            x -= 1 end
        if travel_dir == "RIGHT"
            x += 1 end
        if travel_dir == "DOWN"
            y += 1
        head_pos = [x,y]
        if head_pos == apple_loc
            score += 1
            push!(snake, head_pos)
            spawn_apple()
        else
            push!(snake, head_pos)
            pop!(snake)
        end
        check_dead()
    end

    function draw()
        # reset the grid
        global grid = zeros(20,20)
        for e in snake
            # set values for the snake
            grid[e[1],e[2]] = 1
            scatter!(e[1], e[2] marker=:square, color=:yellow)
        end
        # set values for head / apple
        grid[head_pos[1],head_pos[2]] = 2
        scatter!()
        grid[apple_loc[1], apple_loc[2]] = 3
        
    end

    function play()
        spawn_apple()
        draw()
        while true
            move()
            draw()
            fig
        end
    end
end