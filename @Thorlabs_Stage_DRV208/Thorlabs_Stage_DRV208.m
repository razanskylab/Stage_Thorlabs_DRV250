% File: Thorlabs_Stage_DRV208.m @ Thorlabs_Stage_DRV208
% Author: Urs Hofmann
% Mail: hofmannu@ethz.ch
% Date: 03.02.2021

% Description: class used to control new stage

classdef Thorlabs_Stage_DRV208 < handle

	properties
		pos(1, 1) double; % position of the stage [mm]
		vel(1, 1) double; % velocity of the stage [mm/s]
		acc(1, 1) double; % acceleration of the stage [mm/s2]
		soft_min(1, 1) double = 0;
		soft_max(1, 1) double = 50;
	end

	properties(Hidden, Constant)
		% path to DLL files (edit as appropriate)
		MOTORPATHDEFAULT='C:\Program Files\Thorlabs\Kinesis\';
		% DLL files to be loaded
		DEVICEMANAGERDLL='Thorlabs.MotionControl.DeviceManagerCLI.dll';
		DEVICEMANAGERCLASSNAME='Thorlabs.MotionControl.DeviceManagerCLI.DeviceManagerCLI'
		GENERICMOTORDLL='Thorlabs.MotionControl.GenericMotorCLI.dll';
		GENERICMOTORCLASSNAME='Thorlabs.MotionControl.GenericMotorCLI.GenericMotorCLI';
		STEPPERMOTORDLL='Thorlabs.MotionControl.Benchtop.StepperMotorCLI.dll';  
    STEPPERMOTORCLASSNAME='Thorlabs.MotionControl.Benchtop.StepperMotorCLI.KCubeDCServo';
    
    POS_MAX(1, 1) double = 50; % describes the hardware limit of the stage [mm]
    POS_MIN(1, 1) double = 0; % describes the hardware limit of the stage
    VEL_MAX(1, 1) double = 50;
    VEL_MIN(1, 1) double = 0;
    ACC_MAX(1, 1) double = 50;
    ACC_MIN(1, 1) double = 0;
    TPOLLING(1, 1) = 250; % Default polling time
    TIMEOUTSETTINGS(1, 1) = 7000;
    TIMEOUTMOVE(1, 1) = 100000;
    SERIAL_START = '40'; % start of correct serial number
	end

	properties (SetAccess = private)
		isConnected(1, 1) logical = 0; % status if device is connected or not
		isHomed(1, 1) logical = 0;
		isBusy(1, 1) logical = 0;
		serialnumber = [];
		deviceNET;
		deviceNET_channel;
		motorSettingsNET;
		currentDeviceSettingsNET;
		deviceInfoNET;
	end

	methods

		% class destructor
		function delete(ts)
			ts.Disconnect();
		end

		Load_DLLs(ts);
		corrSerials = List_Devices(ts);
		Connect(ts, varargin);
		Home(ts);
		Move_No_Wait(ts, pos);
		Identify();

		function isBusy = get.isBusy(ts)
			isBusy = ts.deviceNET_channel.IsDeviceBusy;
		end


		function isHomed = get.isHomed(ts)
			isHomed = ~ts.deviceNET_channel.NeedsHoming;
		end

		function set.pos(ts, pos)
			ts.Move_No_Wait(pos);
			ts.Wait_Move();
		end

		% read current position from stage and return to user
		function pos = get.pos(ts)
			pos = System.Decimal.ToDouble(ts.deviceNET_channel.Position);
		end

		% read current maximum velocity from stage and return to user
		function vel = get.vel(ts)
			velparams = ts.deviceNET_channel.GetVelocityParams();
			vel = System.Decimal.ToDouble(velparams.MaxVelocity);
		end

		% set maximum velocity of stage
		function set.vel(ts, vel)
      velpars = ts.deviceNET_channel.GetVelocityParams();
      if isnumeric(vel)
        if (vel <= ts.VEL_MAX) && (vel > 0)
          velpars.MaxVelocity = vel;
          ts.deviceNET_channel.SetVelocityParams(velpars);
        else
          error('Velocity outside of allowed range.');
        end
      else
        error('Invalid datatype.');
      end
    end

		% return currently defined acceleration to user
		function acc = get.acc(ts)
			velparams = ts.deviceNET_channel.GetVelocityParams();
			acc = System.Decimal.ToDouble(velparams.Acceleration);
		end

		% Sets acceleration of the stage
    function set.acc(ts, acc)
      velpars = ts.deviceNET_channel.GetVelocityParams();
      if isnumeric(acc)
        if (acc <= ts.ACC_MAX) && (acc > 0)
          velpars.Acceleration = acc;
          ts.deviceNET_channel.SetVelocityParams(velpars);
        else
          error('Acceleration outside of allowed range.');
        end
      else
        error('Invalid datatype.');
      end
    end



	end


end