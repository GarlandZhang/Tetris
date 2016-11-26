%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher: Ms. Nobrega
%Program Name: GameScreen.t
%Descriptions:  Displays Game Window and initializes variables for game.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayGameWindow -> opens the game window
procedure displayGameWindow

    % Open the window
    var winID : int
    winID := Window.Open ("title:Game Window")
    setscreen ("graphics:600;600")

    % draws tetris background
    drawTetrisBG

    % Display Tetris text overhead
    drawTetrisName

    % Display grid
    drawGrid
  
    % Displays holding area
    drawHoldSquare

    % Display scoreboard
    displayScoreboard
    
    %play music file
    fork playThemeMusic

    %loop for duration of game
    loop

	var randomNum : int := Rand.Int (1, 7)  %random number to choose which tetromino to generate
	var pivotX, pivotY : real %pivot points of tetromino; used to rotate
	var myColor : int %color based on which tetromino is chosen
	var xVal : int := xStart + SIZE * (columnSize div 2 - 1)  %current x-coor positioning of tetromino from the left
	var yVal : int := yStart %current y-coor position of tetromino from the top
	var tetromino : array 1 .. arraySize, 1 .. arraySize of boolean := createTetro (randomNum, pivotX, pivotY, myColor) %2D array to store tetromino ( 4x4 )
	var leftBound, rightBound, topBound, bottomBound : int := 1 %boundaries for tetromino occupied in array
	var heldOnce : boolean := false %checks if user has already held a tetromino this turn.
	holdStatus := false %constantly initializes the current status of holding the tetromino to be false

	% initiates a tetromino to be active by creating, drawing, and allowing it to be interacted with the user onto board
	activeTetromino (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, randomNum, myColor, pivotX, pivotY, heldOnce)

	exit when yVal = yStart and impactIsMadeDown (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)
    end loop

    %stop all music playing
    Music.PlayFileStop

    %draw ending
    drawEnd
    
    % close window
    Window.Close (winID)

end displayGameWindow
