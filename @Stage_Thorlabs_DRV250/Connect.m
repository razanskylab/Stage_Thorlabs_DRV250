% File: Connect.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Description: Connects to the latest seens stage, evtl you can even pass 
% things like serial numbers one day

function Connect(ts, varargin)

	if ~ts.isConnected

		serialnumber = ts.serialnumber;

		for iargin = 1:2:(nargin - 1)
			switch varargin{iargin}
				case 'serialnumber'
					serialnumber = varargin{iargin + 1};
				otherwise
					error('Invalid argument passed to function');
			end
		end

		% if serial number is kept empty lets try to find it automatically
		if isempty(serialnumber)
			serialNumberPull = ts.List_Devices();
			if (length(serialNumberPull) == 1)
				serialnumber = serialNumberPull{1};
			elseif (length(serialNumberPull) > 1)
				serialnumber = serialNumberPull{1};
				warning('Multiple devices found, choosing the first one');
			else
				error('Could not find device automatically');
			end
		end

		 ts.deviceNET = ...
			Thorlabs.MotionControl.Benchtop.StepperMotorCLI.BenchtopStepperMotor.CreateBenchtopStepperMotor(serialnumber);

		%ts.deviceNET.ClearDeviceExceptions(); % Clear device exceptions via .NET interface
		ts.deviceNET.ConnectDevice(serialnumber);
		ts.deviceNET.Connect(serialnumber); % Connect to device via .NET interface, 
		
		% check if connection was successfully established
		if ~ts.deviceNET.IsConnected
			error('Could not connect to stage');
		else
			ts.isConnected = 1;
		end

		ts.serialnumber = serialnumber;

		ts.deviceInfoNET = ts.deviceNET.GetDeviceInfo();
		ts.deviceNET_channel = ts.deviceNET.GetChannel(1);

		if ~ts.deviceNET_channel.IsSettingsInitialized() % Wait for IsSettingsInitialized via .NET interface
    	ts.deviceNET_channel.WaitForSettingsInitialized(ts.TIMEOUTSETTINGS);
	    if ~ts.deviceNET_channel.IsSettingsInitialized() % Cannot initialise device
	      warning(['Unable to initialise device ',char(serialnumber)]);
	    end		
    end

    ts.deviceNET_channel.StartPolling(250);

    ts.motorSettingsNET = ts.deviceNET_channel.LoadMotorConfiguration(serialnumber);



	else
		warning('Device is already connected');		
	end

end