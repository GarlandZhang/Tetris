%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Program Name: Main.t
%Date: 5/25/2015
%Course:  ICS3CU1  Final Project 15%
%Teacher:  Ms. Nobrega
%Descriptions: Where all programs are called and connected. 1747 lines of code in total

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% files/code folder where all programs are included and referenced to
include "files/code/includes.t"

loop

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % procedure to set all initial global variable with file scope
    % even if already set (located in MyGlobalVars.t)
    setInitialGameValues

    %  ********  M A I N   P R O G R A M   S T E P S ********
/*
 1.      Display title screen
 2.      Provide the user with the option to click on instructions button
 a.      If true, then go to instructions screen( change window )
 b.      Else if user presses on play button, go to game screen( change window to game window )
 3.      Tetris Marathon step-step build:
    a.      Draw the grid onto the screen
    b.      Randomly choose one of seven tetromino variations
    c.      Draw tetrominoe onto the middle top of the screen
    d.      Keep track of any keyboard interaction
	i.      If left arrow key is pressed, shift tetromino left by one grid square
	ii.     Else if right arrow key is pressed, shift tetromino right by one grid square
	iii.    Else if up arrow key is pressed, rotate tetromino 90° clockwise by manipulating tetromino array
	iv.     Else if down arrow key is pressed, shift tetromino down by one grid square
	v.      If no interaction is present, delay 1000 milliseconds
    e.      Shift tetromino down automatically by one grid square
 
    f.      Check if tetromino comes in contact with any other previous tetromino( refer to the Boolean returned from the 2D grid array. If grid( i, j ) is true, then previous block from tetromino is present in that current block. ).
    g.      Check if tetromino is at the bottom of grid to stop automatic shift down.
 
    h.      Check grid if any line in the grid is full. If so, clear the line by shifting every row above down. Increment points value by one.
    i.      In five point intervals, increase drop speed of tetromino.
    j.      If tetromino is dropped at the top of the grid, and no other tetrominoes can be generated at the top, record score and input to a high score file. Exit user to the Game Over screen.
    k.      Else, continue looping through steps b to j.
  4. In the game over screen, allow the user to enter their name to record onto a highscore file where data is saved in a file
    a. provide the user to exit the game, or play again by pressing the play again button
 */
    % ***************************************   Major Block A

    % Display the introduction screen
    displayIntroWindow

    % ***************************************   Major Block B

    % Display the game description window
    displayDescriptionWindow

    % ***************************************   Major Block C

    % Display the game instructions window
    displayInstructionsWindow
  
    % ***************************************   Major Block D
    
    % Display the game screen window
    displayGameWindow

    % ****************************************   Major Block E
    
    % Display the game over screen
    displayGameOverWindow
  
    % when the play again button is not pressed, exit the loop and the game
    exit when not isPlayAgainPressed

end loop

    % *********** E N D     O F    P R O G R A M  ************
