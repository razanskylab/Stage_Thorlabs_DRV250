% File: Disconnect.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Description: Disconnects the stage

function Disconnect(ts)

	if ts.isConnected

		ts.deviceNET.Disconnect

		if ts.deviceNET.IsConnected
			error('Could not disconnect device');
		else
			ts.isConnected = 0;
		end
			
	else
		warning('Cannot disconnect because device was never connected');
	end

end