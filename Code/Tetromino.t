%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: Tetromino.t
%Descriptions:  4-block variations, tetrominoes built into 2D arrays.
%Includes all interactions with the tetromino, including manipulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% createTetro -> create a random tetromino by random choice
% @return a boolean array of size 4 X 4 that represents a tetromino
function createTetro (randomNum : int, var pivotX, pivotY : real, var myColor : int) : array 1 .. arraySize, 1 .. arraySize of boolean

    var tetromino : array 1 .. arraySize, 1 .. arraySize of boolean

    case (randomNum) of

	%T-square
	label 1 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (false, true, false, false,
										      true, true, true, false,
										      false, false, false, false,
										      false, false, false, false)

	    %pivot points on 2D array to rotate tetromino clockwise
	    pivotX := 2
	    pivotY := 2
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2
	    
	    %sets color of tetromino
	    myColor := 36

	%Line
	label 2 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (false, false, false, false,
										      true, true, true, true,
										      false, false, false, false,
										      false, false, false, false)
		
	    %pivot points on 2D array to rotate tetromino clockwise            
	    pivotX := 2.5
	    pivotY := 2.5

	    %sets tetromino to current tetromino
	    tetromino := tetromino2

	    %sets color of tetromino
	    myColor := 11

	%2 by 2
	label 3 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (true, true, false, false,
										      true, true, false, false,
										      false, false, false, false,
										      false, false, false, false)
		
	    %pivot points on 2D array to rotate tetromino clockwise                
	    pivotX := 1.5
	    pivotY := 1.5
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2

	    %sets color of tetromino           
	    myColor := 14

	%Z-block
	label 4 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (true, true, false, false,
										      false, true, true, false,
										      false, false, false, false,
										      false, false, false, false)
 
	    %pivot points on 2D array to rotate tetromino clockwise                
	    pivotX := 2
	    pivotY := 2
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2
	    
	    %sets color of tetromino
	    myColor := 12

	%S-block
	label 5 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (false, true, true, false,
										      true, true, false, false,
										      false, false, false, false,
										      false, false, false, false)

	    %pivot points on 2D array to rotate tetromino clockwise                
	    pivotX := 2
	    pivotY := 2
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2
	    
	    %sets color of tetromino
	    myColor := 10

	%backwards L-block ( blue )
	label 6 :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (true, false, false, false,
										      true, true, true, false,
										      false, false, false, false,
										      false, false, false, false)
	  
	    %pivot points on 2D array to rotate tetromino clockwise                
	    pivotX := 2
	    pivotY := 2
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2
	    
	    %sets color of tetromino
	    myColor := 9

	%L-block ( orange )
	label :

	    var tetromino2 : array 1 .. arraySize, 1 .. arraySize of boolean := init (false, false, true, false,
										      true, true, true, false,
										      false, false, false, false,
										      false, false, false, false)
	     
	    %pivot points on 2D array to rotate tetromino clockwise                   
	    pivotX := 2
	    pivotY := 2
	    
	    %sets tetromino to current tetromino
	    tetromino := tetromino2
	    
	    %sets color of tetromino
	    myColor := 42

    end case

    result tetromino

end createTetro

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawTetro -> draws a tetromino according to the given tetromino
procedure drawTetro (var tetromino : array 1 .. *, 1 .. * of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound, myColor : int)

    % only loop through the top and bottom bounds of the 2D tetromino array
    for i : topBound .. bottomBound

	% index of row value on 2D grid array
	var yIndex : int := yVal div SIZE - (i - topBound)

	% only loop through left and right bounds of the 2D tetromino array
	for j : leftBound .. rightBound

	    % if current element is true, then draw onto grid
	    if tetromino (i, j)
		    then

		% index of column value on 2D grid array
		var xIndex : int := (xVal - xStart) div SIZE + j

		% if current x index and y index are valid, then draw squares onto grid as well as reassign values on grid
		if xIndex > 0 and yIndex <= rowSize
			then

		    % if myColor is white, which means to clear tetromino, then set current values of element on grid to white
		    if myColor = white
			    then

			grid (xIndex, yIndex) := white

		    % if space is available, then assign current element on 2D grid array to current color of tetromino piece
		    elsif grid (xIndex, yIndex) = white

			    then

			grid (xIndex, yIndex) := myColor

		    end if

		end if

		% draw the square onto grid that represents tetromino
		Draw.FillBox (SIZE * (j - 1) + xVal, yVal - SIZE * (i - topBound), SIZE * j + xVal, yVal - SIZE * (i - topBound + 1), myColor)            %draws box from top left corner
		Draw.Box (SIZE * (j - 1) + xVal, yVal - SIZE * (i - topBound), SIZE * j + xVal, yVal - SIZE * (i - topBound + 1), blue)

	    end if

	end for

    end for

end drawTetro

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clearTetro -> clears previous drawn tetromino
procedure clearTetro (var tetromino : array 1 .. *, 1 .. * of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound : int)

    drawTetro (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound, white)

end clearTetro

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% identifyBounds -> assigns bounds of the tetromino
procedure identifyBounds (tetromino : array 1 .. *, 1 .. * of boolean, var leftBound, rightBound, topBound, bottomBound : int)

    % assign to polar opposites of boundaries to locate their smalles/greatest values
    leftBound := arraySize
    topBound := arraySize
    rightBound := 1
    bottomBound := 1

    for i : 1 .. arraySize

	for j : 1 .. arraySize

	    if tetromino (i, j)
		    then

		%find greatest bound on the right
		if j > rightBound
			then

		    rightBound := j

		end if

		%find smallest bound on the left
		if j < leftBound
			then

		    leftBound := j

		end if

		%find lowest bound on bottom
		if i > bottomBound
			then

		    bottomBound := i

		end if

		%find highest bound on top
		if i < topBound
			then

		    topBound := i

		end if

	    end if

	end for

    end for

end identifyBounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% moveLeft -> moves tetromino to the left
procedure moveLeft (var xVal : int)

    xVal := xVal - SIZE

end moveLeft

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% moveRight -> moves tetromino to the right
procedure moveRight (var xVal : int)

    xVal := xVal + SIZE

end moveRight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impactIsMadeDown -> checks if tetromino will impact with bottom of grid, or block
% @return returns a boolean true or false if tetromino will impact with block beneath it or the bottom of grid
function impactIsMadeDown (tetromino : array 1 .. *, 1 .. * of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound : int) : boolean

    for i : topBound .. bottomBound

	var yIndex : int := yVal div SIZE - (i - topBound)

	for j : leftBound .. rightBound

	    if tetromino (i, j)
		    then

		var xIndex : int := (xVal - xStart) div SIZE + j

		% check bottom grid element if there is space available. If there is not, return true that tetromino will make contact with below piece.
		if grid (xIndex, yIndex - 1) not = white
			and (i = bottomBound or (i not = bottomBound and not tetromino (i + 1, j))) % check that the block beneath isn't apart of the tetromino
			then

		    result true

		end if

	    end if

	end for

    end for

    result false

end impactIsMadeDown

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impactIsMadeLeft -> checks if tetromino will collide with other tetromino to its left
% @return returns a boolean true or false if tetromino will impact with block to the left
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function impactIsMadeLeft (tetromino : array 1 .. *, 1 .. * of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound : int) : boolean

    for i : topBound .. bottomBound

	var yIndex : int := yVal div SIZE - (i - topBound)

	for j : leftBound .. rightBound

	    if tetromino (i, j)
		    then

		var xIndex : int := (xVal - xStart) div SIZE + j
		
		%check grid element to the left if there is a piece occupying space. If there is, then return true contact will be made.
		if grid (xIndex - 1, yIndex) not= white
			and j = leftBound %check if this is the left most piece. <-- Will check most left bound of tetromino first nonetheless and will return true. Redundant but easier to understand. 
			then

		    result true

		end if

	    end if

	end for

    end for

    result false

end impactIsMadeLeft

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% impactIsMadeRight -> checks if tetromino will collide with other tetromino to its right
% @return returns a boolean true or false if tetromino will impact with block to the right
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function impactIsMadeRight (tetromino : array 1 .. *, 1 .. * of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound : int) : boolean

    for i : topBound .. bottomBound

	var yIndex : int := yVal div SIZE - (i - topBound)

	for j : leftBound .. rightBound

	    if tetromino (i, j)
		    then

		var xIndex : int := (xVal - xStart) div SIZE + j
		
		% checks the grid element to the right of current tetromino element if space is occupied. If piece is occupying space, return true that contact will be made.
		if grid (xIndex + 1, yIndex) not= white
			and (j = rightBound or (j not= rightBound and not tetromino (i, j + 1))) % checks to make sure this is not part of the tetromino piece.
			then

		    result true

		end if

	    end if

	end for

    end for

    result false

end impactIsMadeRight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkGrid -> checks the grid if grid squares where tetromino will rotate are empty
% @return boolean if tetromino can rotate
function checkGrid (rotatedTetro : array 1 .. arraySize, 1 .. arraySize of boolean, xVal, yVal, leftBound, rightBound, topBound, bottomBound : int, pivotX, pivotY : real) : boolean

    for i : topBound .. bottomBound %goes vertically, starting from top

	var yIndex : int := yVal div SIZE - (i - topBound)

	for j : leftBound .. rightBound %goes horizontally, starting from left

	    %checks if current element in prerotated tetromino is true. If so, then check if space is available in where element would be drawn onto grid.
	    if rotatedTetro (i, j)
		    then

		var xIndex : int := (xVal - xStart) div SIZE + j

		% performs checks to make sure that rotated tetromino will not rotate out of boundaries or overlap already occupied space.
		if xIndex > columnSize 
			or xIndex <= 0
			or grid (xIndex, yIndex) not= white
			then

		    result false

		end if

	    end if

	end for

    end for

    result true

end checkGrid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rotate -> rotates tetromino 90 degrees clockwise. Manipulates 2D array to change tetromino structure.
% @return 2D boolean array of the rotated tetromino
function rotate (var tetromino : array 1 .. arraySize, 1 .. arraySize of boolean, pivotX, pivotY : real) : array 1 .. arraySize, 1 .. arraySize of boolean

    var tempTetro : array 1 .. arraySize, 1 .. arraySize of boolean

    %initialize tetromino
    for i : 1 .. arraySize

	for j : 1 .. arraySize

	    tempTetro (i, j) := false

	end for

    end for

    %sets true to elements in tempTetro
    for i : 1 .. arraySize

	for j : 1 .. arraySize

	    if tetromino (i, j)
		    then

		%algorithm to get new points on the 2D array. Assigns new values to elements in 2D array
		tempTetro (round (j - pivotX + pivotY), round (- (i - pivotY) + pivotX)) := true   %reverse form because 2D array goes row x column.
												   %Since j is changing and j is in the 2nd coordinate, therefore j is the x-coordinate.

	    end if

	end for

    end for

    result tempTetro

end rotate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drop -> drops the tetromino to lowest square possible
procedure drop (tetromino : array 1 .. *, 1 .. * of boolean, xVal, leftBound, rightBound, bottomBound, topBound : int, var yVal : int)

    loop

	exit when yVal div SIZE - (bottomBound - topBound + 1) = 0
	    or impactIsMadeDown (tetromino, xVal, yVal, leftBound, rightBound, topBound, bottomBound)

	yVal := yVal - SIZE

    end loop

end drop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hold -> holds the current tetromino in empty hold slot
procedure hold (randomNum : int)

    holdNum := randomNum

end hold

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% switch -> switches tetromino being held with current tetromino
procedure switch (var randomNum : int)

    %switch tetromino id numbers
    var tempNum : int := randomNum
    randomNum := holdNum
    holdNum := tempNum

end switch
