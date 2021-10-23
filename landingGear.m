function G = landingGear(propDiam, fuselageHeight, fuselageWidth)

%This function computes different parameters for the landing gear
%Inputs: PropDiam = diameter of propellor (inches)
%        fuselageHeight = height of the fuselage (inches)
%Outputs: A vector G with the following values:
%   G = [gearWeight gearParaDrag gearSA wheelSA]

%Height of landing gear is the difference between prop radius and fuselage height
%-------------------------------------------------------------------------%
%----------------------Calculation of Gear Weight-------------------------%
height = .5*propDiam - fuselageHeight + 1; %1" clearence 
top = fuselageWidth;
theta = 38*pi/180;   %Angle of inside of bend (minus 90)
rho_Gear = 1;   %Density for landing gear material (slug/in^3)
t = 1/8;        %thickness of flatbar (in)
area_Al= (top + 2*(height/cos(theta)+height))*t;
gearwidth = 1;      %width of flatbar (in)
volume_Al = area_Al*gearwidth;
gearWeight = rho_Gear*volume_Al;
%-------------------------------------------------------------------------%
%------------------Calculation of Gear Surface Area-----------------------%
width_wheel = 0.5;    %width of wheels (in)
radius_wheel = 1.5; %wheel radius
gearSA=2*(height/cos(gearBendAngle)+height)*gearwidth/144;
wheelSA=(2*pi*(radius_wheel)^2+ pi*2*radius_wheel*width_wheel)/144;
%-------------------------------------------------------------------------%
%------------------------Parasitic Drag Function--------------------------%
area_wheel = width_wheel*radius_wheel*3*2;    %profile area for 3 wheels
drag_Al =@(v) Cd_Al*rho_air*(v*12)^2*area_Al*.5; %aluminum bar
drag_wheel = @(v) Cd_wheel*rho_air*(v*12)^2*2*area_wheel*.5;
gearParaDrag=@(v) drag_Al(v)+drag_wheel(v); %p for parasitic
%-------------------------------------------------------------------------%
%--------------------------------Output-----------------------------------%
G = [gearWeight gearParaDrag gearSA wheelSA];
%-------------------------------------------------------------------------%