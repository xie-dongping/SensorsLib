within SensorsLib.Generic.Errors;

model NonlinearityError
  "Nonlinearity calibration error of the sensor"

  import SensorsLib.Generic.Errors.Functions.splineCoefficients;
  import SensorsLib.Generic.Errors.Functions.pureRandom;
  import SensorsLib.Generic.Errors.SplineError;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Integer numberOfPoints = 6;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  input Real u;
  output Real errorValue "Nonlinearity error value in operating range";

  SplineError splineError(gain=gain, inputMax=inputMax, inputMin=inputMin,
                          numberOfPoints=numberOfPoints);

protected
  constant Integer numberOfCoeffients = 4;
  Real x[numberOfPoints] = linspace(inputMin, inputMax, numberOfPoints);
  Real y[numberOfPoints];
  Real coefficients[numberOfPoints-1, numberOfCoeffients];

equation
  for i in 1:numberOfPoints loop
    y[i] = pureRandom(localSeed + i, globalSeed, -errorMax, errorMax);
  end for;

  for i in 1:(numberOfPoints-1) loop
    coefficients[i, :] = splineCoefficients(x[i], y[i], x[i+1], y[i+1]);
  end for;

  splineError.u = u;
  splineError.coefficients = coefficients;
  splineError.y = y;

  errorValue = splineError.errorValue;

end NonlinearityError;
