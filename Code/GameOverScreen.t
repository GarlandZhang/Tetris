%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher: Ms. Nobrega
%Program Name: GameOverScreen.t
%Descriptions:  Overall use of procedures to display game over screen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% variables
var fileName : string := "Files/Text/HighScores.txt" % file name of high scores file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numberOfPlayers -> gets the number of players in the highscore menu
% @return number of players
function numberOfPlayers (fileName : string) : int

    var stream : int

    open : stream, fileName, get % open file and get data

    var sLine : string

    var count : int := 0 %counts number of players, initially starts at 0.

    loop

	exit when eof (stream)

	get : stream, sLine : *

	count := count + 1 %increment counter variable to record number of players

    end loop

    close : stream

    result count

end numberOfPlayers

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sortFile -> sorts highscore file to be in highest score to lowest
procedure sortFile

    var stream : int

    open : stream, fileName, get

    const longestLengthName : int := 10 %longest length of a username before cutting it off to save space
    const topTen : int := 10 % record top ten players
    var placement : int := 1 %counter variable. Also used as input to record which place each player is in for score
    var sFile : string := "" %string used to overwrite former file by building string to save entire high score board
    var userPlace : string % stores place of current user
    var userName : string % stores current username
    var score : string % stores current score of user
    var found : boolean := false %checks if placement for user is found

    % set background of where text is red
    colorback (40)
    locatexy (maxx div 2 - 30, maxy div 2 - 40) % location of where use inputs name

    loop

	get : stream, skip

	exit when eof (stream) or placement > topTen

	% get data in order of place, name, and score
	get : stream, userPlace
	get : stream, userName
	get : stream, score

	% if placement is not found and score is higher than current user score, place player's name and data here
	if not found and clearedLines > strint (score)
		then

	    found := true

	    %gets the players name from user
	    var playerName : string
	    get playerName

	    %checks if username length is > the longest length name allowed - 3. If so, shorten length and add "..."
	    if length (playerName) > longestLengthName - 3
		    then

		playerName := playerName (1 .. longestLengthName - 3) + "..."

	    end if

	    %builds string to display scores. Builds current player
	    sFile := sFile + intstr (placement) + " " + playerName + repeat (" ", longestLengthName - length (userName) + 1) + intstr (clearedLines) + "\n"
	    placement := placement + 1

	end if

	%checks if username length is > the longest length name allowed - 3. If so, shorten length and add "..."
	if length (userName) > longestLengthName - 3
		then

	    userName := userName (1 .. longestLengthName - 3) + "..."

	end if

	%builds string to display scores. Builds from current username and sccore
	sFile := sFile + intstr (placement) + " " + userName + repeat (" ", longestLengthName - length (userName) + 1) + score + "\n"
	placement := placement + 1

    end loop

    close : stream

    %if entire list has no valid placement, put player at the bottom of list only if qualifies to be placed in top ten
    if not found and placement <= topTen
	    then

	%gets the players name from user
	var playerName : string
	get playerName

	%checks if username length is > the longest length name allowed - 3. If so, shorten length and add "..."
	if length (playerName) > longestLengthName - 3
		then

	    playerName := playerName (1 .. longestLengthName - 3) + "..."

	end if

	sFile := sFile + intstr (placement) + " " + playerName + repeat (" ", longestLengthName - length (playerName) + 1) + intstr (clearedLines) + "\n"

    end if

    open : stream, fileName, put

    put : stream, sFile %input string into file

    close : stream

end sortFile
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayScore -> displays high scores and usernames
procedure displayScore

    var fontID : int := Font.New ("Times New Roman:20")

    Font.Draw ("Highscores ", 35, maxy - 50, Font.New ("Times New Roman:26:bold"), yellow)

    var stream : int

    open : stream, fileName, get

    var sLine : string
    var counter : int := 0

    %draws border around highscores
    Draw.Box (20, 20, 250, maxy - 10, yellow)

    loop

	exit when eof (stream) or counter = 10

	% gets each line in the file. Each line includes : placement, username, and score respectively
	get : stream, sLine : *

	% draws information onto high score board sheet
	Font.Draw (sLine, 30, maxy - (70 + 35 * (counter + 1)), fontID, yellow)

	% draws line to outline each score
	Draw.Line (20, maxy - (75 + 35 * counter), 250, maxy - (75 + 35 * counter), yellow)

	% increment counter
	counter := counter + 1

    end loop

    close : stream

end displayScore

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displaySubmitText -> displays text "submit" for user to know where to submit score
procedure displaySubmitText

    var fontNum : int := Font.New ("Times New Roman:18")

    Font.Draw ("SUBMIT", maxx div 2 - 40, maxy div 2 - 20, fontNum, yellow) % directs user to where to submit name

end displaySubmitText

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playGameOver -> plays game over music file
process playGameOver

    Music.PlayFile ("Sounds/gameOver.mp3")

end playGameOver

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayGameOverWindow -> displays game over window
procedure displayGameOverWindow

    isGameOverWindow := true

    % Open the window
    var winID : int
    winID := Window.Open ("position:top;center,graphics:600;450,title:Game Over Window")

    %display tetris background
    drawTetrisBG

    %display image of game over
    drawGameOver

    %display submit text
    displaySubmitText

    %display play again button
    var playAgainButton := GUI.CreateButton (maxx - 200, maxy div 2 - 50, 0, "PLAY AGAIN?", playAgainPressed)

    %display exit button
    var exitButton := GUI.CreateButton (maxx - 200, maxy div 2 - 100, 0, "EXIT", exitButtonPressed)

    %plays game over music
    fork playGameOver

    %display highscore vs user's score
    displayScore

    %sorts file according to highscore
    sortFile

    loop

	exit when GUI.ProcessEvent or not isGameOverWindow

    end loop

    GUI.Dispose (playAgainButton)

    %draw ending
    drawEnd
    
    Window.Close (winID)

end displayGameOverWindow
