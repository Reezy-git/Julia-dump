begin
    using GLMakie

    res = 500
    sizea = 10
    game = Scene(resolution = (res, res))
    limits! = (game, 0, sizea, sizea, sizea)
    cell_size = res / sizea + 1
    head =  Observable(Point2(res/2, res/2))
    global alive = true
    scatter!(game, head, markersize=cell_size, marker=:"🟩")

    # 🍎
    
    game_matrix = zeros(sizea, sizea)

        
    display(game)

    global last_dir = (0, 1)

    on(events(game).keyboardbutton) do event
        if event.action in (Keyboard.press, Keyboard.repeat)
            global last_dir
            event.key == Keyboard.left && return (last_dir = (-1, 0))
            event.key == Keyboard.right && return (last_dir = (1, 0))
            event.key == Keyboard.up && return (last_dir = (0, 1))
            event.key == Keyboard.down && return (last_dir = (0, -1))
        end
        return Consume(false)
    end
    function move()
        head[] = head[] .+ Point2(last_dir .* cell_size)
    end
    display(game)
    campixel!(game)

end
while alive
    move()
    sleep(0.5)
end
display(game)
