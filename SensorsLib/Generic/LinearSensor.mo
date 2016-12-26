within SensorsLib.Generic;

model LinearSensor
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Real gain(unit="1", min=0) = 1 "The scaling function from input to output";
  parameter Real outputMax(unit="1") = 1 "Maximal sensor output";
  parameter Real outputMin(unit="1") = 0 "Minimal sensor output";
  parameter Real errorCalibration(unit="1", min=0) = 1
    "Maximum calibration error for two point calibration";
  parameter Real errorNonlinearity(unit="1", min=0) = 1
    "Maximum nonlinearity error";
  parameter Real errorHystersis(unit="1", min=0) = 0
    "Maximum hystersis error";
  parameter Real errorRepeatability(unit="1", min=0) = 0
    "Maximum repeatablity error";
  parameter Real inputDeadBand(unit="1", min=0) = 0
    "Minimum input to be detected";
  SensorsLib.Generic.Errors.CalibrationError calibrationError;
equation
  y = gain * u + calibrationError(u, outputMax, outputMin, errorCalibration);

end LinearSensor;
