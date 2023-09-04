function [plane] = Mission2score(plane)

    turnRadius = plane.performance.velocity^2/acceleration;
    %Estimates the overall lap distance in ft
    %2 360 turns per lap
    lapDist = (500*4)+(2*2*pi*turnRadius);
    lapTime = lapDist/plane.performance.velocity2;
    
    plane.performance.score2 = plane.performance.m2Weight/lapTime;

end