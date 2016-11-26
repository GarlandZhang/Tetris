%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: drawImages.t
%Descriptions:  Draws required images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawLogo -> draws Tetris Logo
procedure drawLogo

    %picture file to store image
    var logo : int := Pic.FileNew ("Images/TetrisLogo.gif")

    %rescale to larger size
    logo := Pic.Scale (logo, Pic.Width (logo) div 1.5, Pic.Height (logo) div 1.5)

    %draw picture
    Pic.Draw (logo, maxx div 2 - 215, 50, picMerge)

    %free memory
    Pic.Free (logo)

end drawLogo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawDemo -> draws Tetris Demo
procedure drawDemo

    %record file name
    var fileName : string := "Images/tetrisDemo.gif"

    %record number of frames
    var numFrames := Pic.Frames (fileName)

    var delayTime : int

    var pics : array 1 .. numFrames of int

    % Load the picture
    Pic.FileNewFrames (fileName, pics, delayTime)
    for i : 1 .. numFrames

	% delay to see step to step animation
	delay (100)

	% draw scaled frame
	Pic.Draw (Pic.Scale (pics (i), maxx, maxy), 0, 0, picMerge)

	% free memory
	Pic.Free (pics (i))

    end for

end drawDemo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawBattleKeys -> draws all keyboard controls that can be used in the game
procedure drawBattleKeys

    %picture file to store image
    var picId : int := Pic.FileNew ("Images/battleKeys.gif")

    %resize to larger scale
    picId := Pic.Scale (picId, round (Pic.Width (picId) * (4 / 3)), round (Pic.Height (picId) * (4 / 3)))

    %draw image
    Pic.Draw (picId, maxx div 2 - Pic.Width (picId) div 2, maxy div 2 - Pic.Height (picId) + 100, picMerge)

    %free memory
    Pic.Free (picId)

end drawBattleKeys

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawTetrisBG -> draws Tetris background
procedure drawTetrisBG

    %picture file to store image
    var picId : int := Pic.FileNew ("Images/tetrisBG.gif")

    %rescale to screen size
    picId := Pic.Scale (picId, maxx, maxy)

    %draw and merge with picture in background
    Pic.Draw (picId, 0, 0, picMerge)

    %free memory
    Pic.Free (picId)

end drawTetrisBG

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawTetrisName -> draws Tetris name
procedure drawTetrisName
    %picture file to store image
    var picId : int := Pic.FileNew ("Images/tetrisName.gif")

    %rescale to screen size
    picId := Pic.Scale (picId, Pic.Width( picId ) div ( 5 / 2 ), Pic.Height( picId ) div 2 )

    %draw image in background
    Pic.Draw (picId, 172, maxy - 50, 0)

    %free memory
    Pic.Free (picId)


end drawTetrisName

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawGameOver -> draws game over text
procedure drawGameOver

    % picture file to store image
    var picId : int := Pic.FileNew ("Images/gameOver.gif")

    % rescale
    picId := Pic.Scale (picId, maxx div 2, maxy div 2)

    %draw image
    Pic.Draw (picId, maxx div 2 - 10, maxy div 2, picMerge)

    %free memory
    Pic.Free (picId)

end drawGameOver

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawEnd -> draws animation to change screens
procedure drawEnd

var x : int := 0
var y : int := maxy

var moveRight : boolean := true
var moveDown : boolean := false
var moveLeft : boolean := false
var moveUp : boolean := false

%which layer the circle is currently on
var layer : int := 0

loop

Draw.FillOval( x, y, SIZE, SIZE, Rand.Int( 1, 255 ) ) 
Draw.Oval( x, y, SIZE, SIZE, Rand.Int( 1, 255 ) )

delay( 10 )

%end when circle is at the middle
exit when x + SIZE div 2 >= maxx div 2 and x + SIZE div 2 <= maxx div 2 + SIZE and y + SIZE div 2 >= maxy div 2 and y + SIZE div 2 <= maxy div 2 + SIZE

%if top right corner
if x >= maxx - SIZE * layer and y >= maxy - SIZE * layer
then

moveRight := false
moveDown := true

end if

%if bottom right corner
if y <= SIZE * layer and x >= maxx - SIZE * layer
then

moveDown := false
moveLeft := true

end if

%if bottom left corner
if x <= SIZE * layer and y <= SIZE * layer
then

moveLeft := false
moveUp := true

end if

% if top left corner - ( layer + 1 )
if y >= maxy - SIZE * ( layer + 1 ) and x <= SIZE * layer and moveUp and not moveRight
then

moveUp := false
moveRight := true
layer := layer + 1

end if

if moveRight
then

    x := x + SIZE % move right

elsif moveDown
then

    y := y - SIZE % move down
    
elsif moveLeft
then

    x := x - SIZE % move left

elsif moveUp
then

    y := y + SIZE % move up
    
end if

end loop

end drawEnd
