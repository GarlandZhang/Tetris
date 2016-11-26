%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 5/25/2015
%Course:  ICS3CU1
%Teacher:  Ms. Nobrega
%Program Name: MyGlobalVars.t
%Descriptions:  Where global variables are created and initialized
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   MyGlobalVars.t
%   All global variables are coded in this file.
%   These will have FILE scope.
%   These must be document thoroughly - Descriptive name,
%   where used and for what purpose

const columnSize : int := 10 % number of columns in grid
const rowSize : int := 22 % number of rows in grid
const SIZE : int := 25 % size of each grid block in game and tetromino
const xStart : int := 175 %start of tetromino x-val
const yStart : int := rowSize * SIZE %start of tetromino y-val
const arraySize : int := 4 % size of length and width of 2D tetromino array
const mileStone : int := 5 % milestone to reach to increment level
const timeDeviationSize : int := 50
const holdX : int := xStart - 5 * SIZE %x-coordinate of where held tetromino is kept
const holdY : int := maxy div 2 + 1 %y-coordinate of where held tetromino is kept
const holdSize : int := 5 * SIZE
var isIntroWindowOpen : boolean % Flag for Introduction Window state open or closed
var isPlayWindowOpen : boolean % checks if play window is open
var isInstructionsWindowOpen : boolean % checks if instructions window open
var isDescriptionWindowOpen : boolean % checks if description window is open
var isGameOverWindow : boolean % checks if game window is open
var isPlayAgainPressed : boolean % checks if play again button is pressed
var firstHold : boolean %checks if first time user holds tetromino
var holdStatus : boolean %checks if user held tetromino during the tetromino activation
var level : int % stores current level of game
var timeElapsed : int % stores amount of time elapsed
var timeKeep : int % stores time intervals between next automatic drop of tetromino
var grid : array 1..columnSize, 1..rowSize of int % grid to keep track of grid squares occupied and their color
var holdTetro : array 1..arraySize, 1..arraySize of boolean
var holdColor : int %hold number of tetromino identified with.
var holdNum : int %holds the tetromino id number
var holdLB, holdRB, holdTB, holdBB : int %holds boundaries of tetromino
var clearedLines : int %stores number of lines cleared 

proc setInitialGameValues

    isIntroWindowOpen := false
    isPlayWindowOpen := false
    isInstructionsWindowOpen := false
    isDescriptionWindowOpen := false
    isGameOverWindow := false
    isPlayAgainPressed := false
    firstHold := true
    holdStatus := false
    
    level := 1
    clearedLines := 0
    timeKeep := 1000
    
    % initialize each grid square to false
    for i : 1..columnSize
    
	for j : 1..rowSize
	
	grid( i, j ) := white
	
	end for
	
    end for

end setInitialGameValues
