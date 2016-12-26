within SensorsLib.Generic;

package Errors
  extends Modelica.Icons.Package;





encapsulated model NonlinearityError
  "Calculate nonlinearity error of the sensor"
  import SensorsLib.Generic.Errors.pureRandom;
  parameter Real u;
  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;
  parameter Integer numberOfPoints = 5;
  
  Real leftError = errorMax * (0.5 - pureRandom(localSeed, globalSeed));
  Real rightError = errorMax * (0.5 - pureRandom(localSeed, globalSeed));
  Real normalizedPosition = (u - inputMin) / (inputMax - inputMin);
  output Real errorValue = leftError + (rightError - leftError) * normalizedPosition;

end NonlinearityError;
end Errors;
