within SensorsLib.Generic.Errors;

encapsulated model NonlinearityError
  "Nonlinearity calibration error of the sensor"

  import SensorsLib.Generic.Errors.Functions.pureRandom;
  import SensorsLib.Generic.Errors.Functions.SplineError;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Integer numberOfPoints = 6;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  input Real u;
  output Real errorValue "Nonlinearity error value in operating range";

  SplineError splineError(gain=gain, inputMax=inputMax, inputMin=inputMin);

protected
  constant Integer numberOfCoeffients = 4;
  Real x[numberOfPoints] = linspace(inputMin, inputMax, numberOfPoints);
  Real y[numberOfPoints];
  Real coefficients[numberOfPoints-1, numberOfCoeffients];

equation

  for i in 1:numberOfPoints loop
    y[i] = pureRandom(localSeed + i, globalSeed, -errorMax, errorMax);
  end for;

  splineError.x = x;
  splineError.y = y;
  splineError.u = u;

  errorValue = splineError.errorValue;

end NonlinearityError;
