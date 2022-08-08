
begin
    using Makie

    res = 500
    game = Scene(resolution = (res, res))
    limits! = (ax, 0, size, size, size)
    head =  Observable(Point2(5, 5))
    scatter!(game, head)
    size = 10

        
    display(game)

    global last_dir = (0, 1)
    dir = lift(game.events.keyboardbuttons) do but
        global last_dir
        ispressed(but, Keyboard.left) && return (last_dir = (-1, 0))
        ispressed(but, Keyboard.up) && return (last_dir = (0, 1))
        ispressed(but, Keyboard.right) && return (last_dir = (1, 0))
        ispressed(but, Keyboard.down) && return (last_dir = (0, -1))
        last_dir
    end

    display(game)
    function move()
        head[] = head[] .+ Point2(dir)
    end

    while head[][2] < size
        move()
    end
end
