%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: Grid.t
%Descriptions:  Grid functions/procedures
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawGrid -> draws the grid onto screen
procedure drawGrid

    % y-coor of where box will be first drawn
    var y : int := 0

    for i : 1 .. rowSize % loop through each row to draw box

	% x-coor of where box will be first drawn
	var x : int := xStart

	for j : 1 .. columnSize % loop through each column to draw box

	    % draw the box with the corresponding colour from the 2D grid as well as outline in blue
	    Draw.FillBox (x, y, x + SIZE, y + SIZE, grid (j, i))
	    Draw.Box (x, y, x + SIZE, y + SIZE, blue)

	    % increment current x value
	    x := x + SIZE

	end for

	% increment current y value
	y := y + SIZE

    end for

end drawGrid

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% isFull -> checks if row is full
% @return boolean if row is full
function isFull (rowNum : int) : boolean

    for i : 1 .. columnSize

	% if any box is white, therefore empty, the row is not filled. Return false
	if grid (i, rowNum) = white
		then

	    result false

	end if

    end for

    result true % if not box is white, therefore full, return true.

end isFull

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkToClear -> checks if there is at least one line to clear
% @return boolean true or false if there is a line to clear
function checkToClear : boolean

    for i : 1 .. rowSize

	% check if row is filled.
	if isFull (i)
		then

	    result true

	end if

    end for

    result false

end checkToClear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playLineClear -> plays .wav file when line(s) is/are cleared
process playLineClear

    Music.PlayFile ("Sounds/clearLineSound.wav")

end playLineClear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clearLine -> clears full line and updates grid
procedure clearLine

    var i : int := 1
    var numOfLinesCleared : int := 0

    loop

	%checks if row is full
	if isFull (i)
		then

	    for j : 1 .. columnSize

		% make current box white to show current row is cleared
		Draw.FillBox (SIZE * (j - 1) + xStart, SIZE * (i - 1), SIZE * j + xStart, SIZE * i, white)
		Draw.Box (SIZE * (j - 1) + xStart, SIZE * (i - 1), SIZE * j + xStart, SIZE * i, blue)

		% animate an oval to cover box to show line being cleared
		Draw.FillOval (SIZE * (j - 1) + xStart + SIZE div 2, SIZE * (i - 1) + SIZE div 2, SIZE div 2, SIZE div 2, black)

	    end for

	    % increment number of lines cleared
	    numOfLinesCleared := numOfLinesCleared + 1

	end if

	% increment row value
	i := i + 1

	exit when i = rowSize

    end loop

    %insert explosion sound
    fork playLineClear

    delay (125)
    clearedLines := clearedLines + numOfLinesCleared

    % reuse variable
    i := 1

    loop

	%checks if row is full
	if isFull (i)
		then

	    for j : i .. rowSize - 1

		for k : 1 .. columnSize

		    if i not= rowSize
			    then

			% bring each row in grid down by assigning value of each element corresponding to the one above
			grid (k, j) := grid (k, j + 1)

		    end if

		end for

	    end for

	    %for the case of the last row, make it white since there is no above row to assign element to current row.
	    for j : 1 .. columnSize

		%set to white
		grid (j, rowSize) := white

	    end for

	else

	    %increment counter to 1
	    i := i + 1

	end if

	exit when i = rowSize

    end loop

end clearLine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawHoldSquare -> draws white space where tetromino is held
procedure drawHoldSquare

    Draw.FillBox (holdX, holdY, holdX + holdSize, holdY + holdSize, white)
    Draw.Box (holdX, holdY, holdX + holdSize, holdY + holdSize, blue)

end drawHoldSquare

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% redrawGame -> redraws all components of game
procedure redrawGame

    drawTetrisBG % draw tetris background
    displayScoreboard % draw scoreboard
    drawGrid % draw grid
    drawHoldSquare % draw space occupying where teteromino being held is.
    drawTetrisName % draw tetris name over grid
    
end redrawGame
