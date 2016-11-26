%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Programmer: Garland Zhang
%Date: 14/06/2015
%Course: ICS3U1
%Teacher: Ms.Nobrega
%Program Name: Scoreboard.t
%Descriptions:  Displays scoreboard details
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% displayScoreboard -> creates a board where score is displayed
procedure displayScoreboard

    %font used to draw text
    var fontNum : int := Font.New ("arial:24:bold")

    %draws score symbol
    Font.Draw ("Score: " + intstr (clearedLines), maxx div 2 + 125, maxy - 150, fontNum, yellow)

    %draw level symbol

    Font.Draw ("Level: " + intstr (level), 10, maxy - 150, fontNum, yellow)

end displayScoreboard

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkScore -> checks if score reaches milestone
% @return if score surpasses milestone
function checkScore : boolean

    result clearedLines >= mileStone * level

end checkScore

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% levelUp -> increments level by one
procedure levelUp

    level := level + 1

end levelUp


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% decrementTime -> decrements time by one interval ( 75ms )
procedure decrementTime

    timeKeep := timeKeep - timeDeviationSize %decrease time span for tetromino dropping

end decrementTime
