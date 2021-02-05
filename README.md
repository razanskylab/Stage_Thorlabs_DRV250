# Thorlabs_Stage_LNR502

A MATLAB interfacing library for the linear long-travel translation stage with the stepper motor actuator used in combination with the Benchtop Stepper Controller by Thorlabs. Most probably compatible with other linear stages based on stepper motors as well.

## Installation

The library is based on the .NET interface which comes with the Kinesis software bundle. First download and install the latest Kinesis software from [Thorlabs Website](https://www.thorlabs.com/software_pages/ViewSoftwarePage.cfm?Code=Motion_Control). The interface is written object oriented approach and the small test script should demonstrate the main functionality.

## Knwon issues adn FAQ

### Wrong startup settings
If you change settings in the Kinesis software and make them the default option at the startup of the device this can lead to issue. If something like this occurs, open the settings and make DRV250 the default startup settings for the device.

## Links

*  [Stage LNR502/M](https://www.thorlabs.com/thorproduct.cfm?partnumber=LNR502/M)
*  [Stage LNR502/M Manual](https://www.thorlabs.com/drawings/a72aa2c5ebed694a-68494C7D-F44D-4E78-1E20F94FDFBDC8E7/LNR502_M-Manual.pdf)
*  [Benchtop Stepper Controller](https://www.thorlabs.com/newgrouppage9.cfm?objectgroup_ID=1704)
