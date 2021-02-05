% File: test_thorlabs_stage_drv208.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

clear all; close all;

T = Stage_Thorlabs_DRV250();
T.Load_DLLs();
T.List_Devices();
T.Connect(); % opens a connection to the device
T.Home();

T.vel = 10;
T.acc = 10;
T.pos = 50;
T.pos = 0;

T.vel = 50;
T.acc = 50;
T.pos = 50;
T.pos = 0;

for i=1:20
 T.pos = rand() * 50;
end

T.Disconnect();