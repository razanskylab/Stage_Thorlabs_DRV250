% File: Home.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Description: Homes the thorlabs stage

function Home(ts)

	if ts.deviceNET_channel.NeedsHoming
		ts.deviceNET_channel.Home(600000);
	else
		warning('No need to home');
	end


end