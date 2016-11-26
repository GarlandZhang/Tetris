%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher: Ms.Nobrega
%Program Name: GameScreen.t
%Descriptions:  Button File - code to handle button events
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% QuitIntroWindowButtonPressed -> Intro Window Procedure
procedure QuitIntroWindowButtonPressed

    isIntroWindowOpen := false
    GUI.Quit
    GUI.ResetQuit
    
end QuitIntroWindowButtonPressed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% instrucPressed -> action event to when instructions button is pressed
procedure instrucPressed

    isIntroWindowOpen := false
    isDescriptionWindowOpen := false
    isInstructionsWindowOpen := true
    GUI.Quit
    GUI.ResetQuit
    
end instrucPressed


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% descriptionPressed -> action event to when description button is pressed
procedure descriptionPressed

    isIntroWindowOpen := false
    isDescriptionWindowOpen := true
    GUI.Quit
    GUI.ResetQuit
    
end descriptionPressed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playButtonPressed -> action event to when play button is pressed. Respond by opening game screen
procedure playButtonPressed

    isIntroWindowOpen := false
    isDescriptionWindowOpen := false
    isInstructionsWindowOpen := false
    isPlayWindowOpen := true
    GUI.Quit
    GUI.ResetQuit
    
end playButtonPressed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% playAgainPressed -> action event for when play again button is pressed. Respond by relooping through game.
procedure playAgainPressed

    isPlayAgainPressed := true
    isGameOverWindow := false
    GUI.Quit
    GUI.ResetQuit

end playAgainPressed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% exitButtonPressed -> action event for when exit button is pressed. Responds by exiting the program.
procedure exitButtonPressed

    isGameOverWindow := false
    GUI.Quit
    GUI.ResetQuit

end exitButtonPressed
