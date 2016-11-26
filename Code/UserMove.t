%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Program Name: Tetris Marathon
%Date: 5/25/2015
%Course:  ICS3CU1  Final Project 15% <- encouragement
%Teacher:  Ms. Nobrega
%Descriptions:  Where user interacts with game through the use of the keyboard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playDropSound -> plays drop sound effect from wav file
process playDropSound

    Music.PlayFile ("Sounds/dropSound.wav")

end playDropSound

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playThemeMusic -> plays Tetris theme music
process playThemeMusic

    Music.PlayFileLoop ("Sounds/tetrisMusic.mp3")

end playThemeMusic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% command -> user interacts with the keyboard commands
procedure command (var tetromino : array 1 .. arraySize, 1 .. arraySize of boolean, var xVal, yVal, timeElapsed, leftBound, rightBound, topBound, bottomBound, randomNum, myColor : int, var pivotX, 
    pivotY : real, var heldOnce : boolean)

    loop

	var key : array char of boolean
	Input.KeyDown (key)

	if key (KEY_LEFT_ARROW) % checks if user presses left arrow key.
		and xVal + SIZE * (leftBound - 2) >= xStart
		and not impactIsMadeLeft (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
		then

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    moveLeft (xVal)
	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	elsif key (KEY_RIGHT_ARROW) % checks if user presses right arrow key.
		and xVal + SIZE * rightBound < xStart + SIZE * columnSize
		and not impactIsMadeRight (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    %last check does not check for blocks one unit below. This causes blocks to crash with each other.
	    %also, rotating the tetromino can push blocks.
		then

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    moveRight (xVal)
	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	elsif key (KEY_UP_ARROW) and randomNum not= 3 % checks if user presses up arrow key and tetromino is not 2X2 ( to save time ).
		then

	    var rotatedTetro : array 1 .. arraySize, 1 .. arraySize of boolean

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)

	    rotatedTetro := rotate (tetromino, pivotX, pivotY)
	    identifyBounds (rotatedTetro, leftBound, rightBound, topBound, bottomBound)

	    if checkGrid (rotatedTetro, xVal, yVal, leftBound, rightBound, topBound, bottomBound, pivotX, pivotY)
		    then

		tetromino := rotatedTetro

	    else

		identifyBounds (tetromino, leftBound, rightBound, topBound, bottomBound)

	    end if

	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	elsif key (KEY_DOWN_ARROW) % checks if user presses down arrow key.
		and yVal div SIZE - (bottomBound - topBound + 1) not= 0
		and not impactIsMadeDown (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
		then

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    yVal := yVal - SIZE
	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	elsif key (' ') %checks if spacebar is pressed down to drop tetromino
		then

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    drop (tetromino, xVal, leftBound, rightBound, bottomBound, topBound, yVal) %Drops the bass
	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	    %delays to refresh the keyboard command
	    delay (250)

	    exit

	elsif key ('p') or key (KEY_ESC) %checks if the key 'p' or escape is pressed to pause game. If true, open pause screen
		then

	    %stops current music playing
	    Music.PlayFileStop    
		
	    %displays pause screen
	    displayPauseScreen

	    %redraws all visual images and grid of the game
	    redrawGame

	    % if a current tetromino is being held, draw it
	    if not firstHold
		    then

		drawTetro (holdTetro, holdX + SIZE, holdY + round (3.5 * SIZE), holdLB, holdRB, holdTB, holdBB, holdColor)

	    end if

	    % plays theme music
	    fork playThemeMusic

	    %checks if user presses shift key. This allows a user to hold a tetromino piece.
	elsif key (KEY_SHIFT) and not heldOnce and not holdStatus
		then

	    clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
	    drawHoldSquare

	    %checks if first time tetromino is held
	    if firstHold
		    then

		% sets first time holding tetromino to be true. This variable will only be used once and only for this case.
		firstHold := false
		hold (randomNum)

		holdTetro := createTetro (holdNum, pivotX, pivotY, holdColor)
		identifyBounds (holdTetro, holdLB, holdRB, holdTB, holdBB)

		%set new value to randomNum to create new tetromino
		randomNum := Rand.Int (1, 7)

		%if not first time tetromino is held then automatically switch tetrominoes
	    else

		%sets status of holding the tetromino this turn to be true
		heldOnce := true
		switch (randomNum)

		%create new tetrominoes
		holdTetro := createTetro (holdNum, pivotX, pivotY, holdColor)
		identifyBounds (holdTetro, holdLB, holdRB, holdTB, holdBB)

	    end if

	    %sets status of holding a tetromino this turn to be true
	    holdStatus := true

	    drawTetro (holdTetro, holdX + SIZE, holdY + round (3.5 * SIZE), holdLB, holdRB, holdTB, holdBB, holdColor)

	    %reset coordinates back to starting position
	    xVal := xStart + SIZE * (columnSize div 2 - 1)
	    yVal := yStart

	    tetromino := createTetro (randomNum, pivotX, pivotY, myColor)

	    identifyBounds (tetromino, leftBound, rightBound, topBound, bottomBound)

	    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)

	end if

	delay (125)

	exit when Time.Elapsed >= timeElapsed

    end loop

end command

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% activeTetromino -> introduce new tetromino to the grid
procedure activeTetromino (var tetromino : array 1 .. arraySize, 1 .. arraySize of boolean, var xVal, yVal, leftBound, rightBound, topBound, bottomBound, randomNum, myColor : int, var pivotX, pivotY 
    : real, var heldOnce : boolean)


    %loop for tetromino
    loop

	timeElapsed := Time.Elapsed + timeKeep % increment timeElapsed to define how long tetromino should be sustained in current grid position prior to automatically dropping.
	identifyBounds (tetromino, leftBound, rightBound, topBound, bottomBound)
	drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor)
	command (tetromino, xVal, yVal, timeElapsed, leftBound, rightBound, topBound, bottomBound, randomNum, myColor, pivotX, pivotY, heldOnce)

	exit when yVal div SIZE - (bottomBound - topBound + 1) = 0
	    or impactIsMadeDown (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)

	clearTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)

	yVal := yVal - SIZE %drop tetromino or y value of 2D tetromino array

	% play drop sound
	fork playDropSound

    end loop

    %checks if lines should be cleared
    if checkToClear
	    then

	clearLine
	redrawGame % redraws all visible aspects of the game

	%checks if score surpasses milestone
	if checkScore
		then

	    levelUp %increase level of game, and thus difficulty
	    decrementTime %decrement time of game

	end if

	% check if there is tetromino being held. If so, redraw onto game board.
	if not firstHold
		then

	    drawTetro (holdTetro, holdX + SIZE, holdY + round (3.5 * SIZE), holdLB, holdRB, holdTB, holdBB, holdColor)

	end if

    end if

end activeTetromino
