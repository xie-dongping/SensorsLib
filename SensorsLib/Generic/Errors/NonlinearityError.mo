within SensorsLib.Generic.Errors;

encapsulated model NonlinearityError
  "Nonlinearity calibration error of the sensor"

  import SensorsLib.Generic.Errors.Functions.pureRandom;
  import SensorsLib.Generic.Errors.Functions.splineCoefficients;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Integer numberOfPoints = 6;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  input Real u;
  output Real errorValue "Nonlinearity error value in operating range";


protected
  constant Integer numberOfCoeffients = 4;
  Real x[numberOfPoints] = linspace(inputMin, inputMax, numberOfPoints);
  Real y[numberOfPoints];
  Real coefficients[numberOfPoints-1, numberOfCoeffients];
  Integer rangeNumber;


equation

  for i in 1:numberOfPoints loop
    y[i] = pureRandom(localSeed + i, globalSeed, -errorMax, errorMax);
  end for;

  for i in 1:(numberOfPoints-1) loop
    coefficients[i, :] = splineCoefficients(x[i], y[i], x[i+1], y[i+1]);
  end for;

  if u < inputMin then
    rangeNumber = 0;
    errorValue = y[1];
  elseif u >= inputMax then
    rangeNumber = numberOfPoints;
    errorValue = y[end];
  else
    rangeNumber = max(min(1 + integer((u - inputMin) /
                                      (inputMax - inputMin) *
                                      (numberOfPoints - 1)),
                          (numberOfPoints - 1)),
                      1);
    errorValue = coefficients[rangeNumber, 1] +
                 coefficients[rangeNumber, 2] * u +
                 coefficients[rangeNumber, 3] * u^2 +
                 coefficients[rangeNumber, 4] * u^3;
  end if;

end NonlinearityError;
