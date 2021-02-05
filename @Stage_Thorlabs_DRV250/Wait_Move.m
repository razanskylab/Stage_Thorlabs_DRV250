% File: Wait_Move.m @ Thorlabs_Stafe_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Derscription: Waits for stafe to finish moving

function Wait_Move(ts)
	ts.deviceNET_channel.Wait(ts.TIMEOUTMOVE);
end