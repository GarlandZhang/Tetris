%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: DescriptionScreen.t
%Descriptions:  Procedures of description of game
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawDescription -> draws the description onto screen
procedure drawDescription

    %Title of current window
    Font.Draw ("Description", maxx div 2 - 50, maxy - 30, Font.New ("Times New Roman:12:bold"), white)

    var intFont : int := Font.New ("Times New Roman:10")

    var fileName : string := "Files/Text/Description.txt"
    
    var stream : int
    
    %opens description file
    open : stream, fileName, get
    
    %counter variable to check how many lines there are
    var countLine : int := 0
    
    %current line in file
    var sLine : string
    
    loop
    
    exit when eof( stream )
    
    get : stream, sLine : *

    Font.Draw ( sLine, 50, maxy - 30 * ( countLine + 2 ), intFont, white) 
    
    countLine := countLine + 1
    
    end loop 
    
    close : stream

end drawDescription

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayDescriptionWindow -> displays window where description of game is given
procedure displayDescriptionWindow

    if isDescriptionWindowOpen
	    then
	    
	% Open the window
	var winID : int
	winID := Window.Open ("position:top;center,graphics:900;400,title:Game Description Window")

	%draws tetris background
	drawTetrisBG
	
	% creates button to move to game window
	var playButton := GUI.CreateButton (maxx div 2 + 120, 50, 0, "PLAY", playButtonPressed)
	
	% creates button to move to instructions window
	var instrucButton := GUI.CreateButton (120, 50, 0, "INSTRUCTIONS", instrucPressed)
	
	%draws description onto screen
	drawDescription

	loop

	    exit when GUI.ProcessEvent or isPlayWindowOpen or isInstructionsWindowOpen

	end loop

	GUI.Dispose (playButton)
	GUI.Dispose( instrucButton )

	%draw ending
	drawEnd
	
	Window.Close (winID)

    end if 

end displayDescriptionWindow
