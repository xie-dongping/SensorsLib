within SensorsLib.Generic.Errors;

encapsulated model CalibrationError
  "Calculate calibration error of the sensor"
  import SensorsLib.Generic.Errors.Functions.pureRandom;
  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  Real leftError = errorMax * pureRandom(localSeed, globalSeed, -1, 1);
  Real rightError = errorMax * pureRandom(localSeed, globalSeed, -1, 1);
  Real normalizedPosition = (u - inputMin)/(inputMax - inputMin);

  input Real u;
  output Real errorValue = leftError +
                           (rightError - leftError) * normalizedPosition;
end CalibrationError;
