% File: Move_No_Wait.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021	

function Move_No_Wait(ts, pos)

	if ((pos > ts.POS_MAX) || (pos > ts.soft_max))
		error('Requested position beyond upper movement limit of stage');
	else
		if ((pos < ts.POS_MIN) || (pos < ts.soft_min))
			error('Requested position is beyond lower movement limit of stage');
		else
			try
	      workDone = ts.deviceNET_channel.InitializeWaitHandler(); % Initialise Waithandler for timeout
	      ts.deviceNET_channel.MoveTo(pos, workDone); % Move device to position via .NET interface
	    catch % Device faile to move
	    	error(['Unable to Move device ',ts.serialnumber,' to ',num2str(pos)]);
	    end
	  end
	end

end