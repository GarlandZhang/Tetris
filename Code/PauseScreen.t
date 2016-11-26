%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: PauseScreen.t
%Descriptions:  Displays pause screen. Connects to game screen/window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playJeopardy -> plays jeopardy think music
process playJeopardy

    Music.PlayFileLoop ("Sounds/jeopardyMusic.mp3")

end playJeopardy

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayPauseScreen -> displays screen when game is paused
procedure displayPauseScreen

    %plays jeopardy think music
    fork playJeopardy

    delay (125)

    % create pic file of pause image
    var picId : int := Pic.FileNew ("Images/pauseIMG.gif")

    %rescales to fit screen
    picId := Pic.Scale (picId, maxx, maxy)

    %draws pic
    Pic.Draw (picId, 0, 0, 0)

    loop

	var key : array char of boolean

	Input.KeyDown (key)

	exit when key (KEY_ESC) or key ('p')

    end loop

    % frees memory
    Pic.Free (picId)

    %stop music
    Music.PlayFileStop

end displayPauseScreen
