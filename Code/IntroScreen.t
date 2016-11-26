%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher: Ms. Nobrega
%Program Name:  IntroScreen.t
%Descriptions:  Displays intro screen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayBanner -> displays an intro banner
process displayBanner

    % stores current font
    var intFont : int := Font.New( "Times New Roman:12:bold" )
    Font.Draw( "by : Zhang, Garland", maxx div 2 + 70, 20, intFont, 47 ) %author's name
    
end displayBanner

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playIntro -> plays intro audio
process playIntro

	Music.PlayFile( "Sounds/tada.wav" )
	
end playIntro

% main procedure to handle the intro window
procedure displayIntroWindow

    % flag that intro screen is open - global var isIntroWindowOpen
    isIntroWindowOpen := true
    % Open the window
    var winID : int
    winID := Window.Open ("position:top;center,graphics:600;400,title:Introduction Window")

    %draws tetris demo
    drawDemo
    
    %draws tetris logo
    drawLogo
    
    %playIntroMusic
    fork playIntro
    
    fork displayBanner

    
    % creates a button that directs window to game window
    var playButton := GUI.CreateButton( maxx div ( 3 / 2 ) + 40, maxy div 2 - 60, 0, "PLAY", playButtonPressed )
    
    % creates a button that directs window to instructions window
    var instrucButton := GUI.CreateButton( 50, maxy div 2 - 60, 0, "INSTRUCTIONS", instrucPressed ) 

    % creates a button that directs window to description window
    var descripButton := GUI.CreateButton( 50, maxy div 2 - 100, 0, "DESCRIPTION", descriptionPressed )
    
    % Window will continue until quit button is pressed
    loop
	
	exit when GUI.ProcessEvent or isPlayWindowOpen or isInstructionsWindowOpen or isDescriptionWindowOpen
	
    end loop
    
    % release the button
    GUI.Dispose ( playButton )
    GUI.Dispose ( instrucButton )
    GUI.Dispose( descripButton )
    
    % draw ending
    drawEnd
    
    %close/release the window
    Window.Close (winID)

end displayIntroWindow

