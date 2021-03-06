clear all
close all
clc

%% Robot parameters (in mm):
% base lengths:
wb = 164;
sb = 567;
ub = 327;

% tool lengths:
up = 44;
sp = 76;
wp = 22;

% links lengths:
L = 524;
l = 1244;
h = 0.05*l;

% Base transformations:
T_base1 = Ty(-wb) * Rz(pi);
T_base2 = Tx(sqrt(3)*wb/2) * Ty(0.5*wb) * Rz(-pi/3);
T_base3 = Tx(-sqrt(3)*wb/2) * Ty(0.5*wb) * Rz(pi/3);
T_bases = {T_base1, T_base2, T_base3};

% Tool transformations:
T_tool1 = Ty(-up) * Rz(pi);
T_tool2 = Tx(sp/2) * Ty(wp) * Rz(-pi/3);
T_tool3 = Tx(-sp/2) * Ty(wp) * Rz(pi/3);
T_tools = {T_tool1, T_tool2, T_tool3};

params = [L, l, sb, wb, ub, sp, wp, up, h];

% q = [0 0 0]; % in degrees
% [x, y, z] = FK(q, params, T_bases, T_tools, 1);

%% Testing:
Robot = figure('units','normalized','outerposition',[0 0 1 1]);
global axes_plot links_plot joints_plot end_effector_plot platform_plot
axes_plot = plot3(0,0,0);
hold on
links_plot = plot3(0,0,0);
hold on
joints_plot = plot3(0,0,0);
hold on
end_effector_plot = plot3(0,0,0);

points = 20;
step = -2;
for i=0:points
        
    if ~ishandle(Robot), return, end
    delete([links_plot,joints_plot, platform_plot])
    delete(axes_plot)
    
    q = [i*step*0.5 i*step*2 i*step];
    FK(q, params, T_bases, T_tools, 1);
    drawnow
end

