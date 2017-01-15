within SensorsLib.Generic;

model LinearSensorDiscrete
  extends Modelica.Blocks.Interfaces.SISO;

  import SensorsLib.Generic.LinearSensorContinuous;
  import Modelica.SIunits;

  parameter Real gain(unit="1", min=0) = 1 "The scaling function from input to output";
  parameter Real inputMax(unit="1") = 1 "Maximal sensor input";
  parameter Real inputMin(unit="1") = 0 "Minimal sensor input";
  parameter SIunits.Time timeSample = 0.001
    "Sampling period";
  parameter Real step = 0.01 "Step for quantization";
  parameter SIunits.Time timeConstant = 0.001
    "Time constant for sensor response";
  parameter Real errorCalibration(unit="1", min=0) = 0.1
    "Maximum calibration error for two point calibration";
  parameter Real errorNonlinearity(unit="1", min=0) = 0.1
    "Maximum nonlinearity error";
  parameter Real errorHysteresis(unit="1", min=0) = 0.1
    "Maximum hystersis error";
  parameter Real errorRepeatability(unit="1", min=0) = 0.1
    "Maximum repeatablity error";
  parameter Real inputDeadBand(unit="1", min=0) = 0.04
    "Dead band length";

  LinearSensorContinuous sensor(gain=gain, inputMax=inputMax,
                                inputMin=inputMin,
                                timeConstant=timeConstant,
                                errorCalibration=errorCalibration,
                                errorHysteresis=errorHysteresis,
                                errorNonlinearity=errorNonlinearity,
                                errorRepeatability=errorRepeatability,
                                inputDeadBand=inputDeadBand)
    annotation(Placement(visible = true, transformation(origin = {42, 30},
               extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
end LinearSensorDiscrete;
