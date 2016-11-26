%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher: Ms. Nobrega
%Program Name: InstructionsScreen.t
%Descriptions:  Gives instructions to user and responds when instructions button is pressed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% drawBanner -> draws out instructions
procedure drawBanner

    %Title of current window
    Font.Draw ("Instructions", maxx div 2 - 50, maxy - 30, Font.New ("Times New Roman:12:bold"), black)

    var intFont : int := Font.New ("Times New Roman:12")

    %objective description
    Font.Draw ("Clear as many lines as possible to earn points.", 110, maxy - 70, intFont, black)

    %keyboard command description
    Font.Draw ("Use the keyboard commands to manipulate the tetromino's position.", 40, maxy - 100, intFont, black)

end drawBanner

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayInstructionsWindow -> opens instructions window
procedure displayInstructionsWindow

    if isInstructionsWindowOpen
	    then

	% Open the window
	var winID : int
	winID := Window.Open ("position:top;center,graphics:600;400,title:Instructions Window")

	% creates button to move to game window
	var playButton := GUI.CreateButton (maxx div 2 - 60, 50, 0, "PLAY", playButtonPressed)

	%draws instructions
	drawBanner

	%draws keyboardcontrols
	drawBattleKeys

	loop

	    exit when GUI.ProcessEvent or isPlayWindowOpen

	end loop

	GUI.Dispose (playButton)

	%draw ending
	drawEnd
	
	Window.Close (winID)

    end if

end displayInstructionsWindow
