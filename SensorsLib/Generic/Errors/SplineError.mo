within SensorsLib.Generic.Errors;

encapsulated model SplineError

  import SensorsLib.Generic.Errors.Functions.splineCoefficients;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;

  input Real u;
  input Real x[:];
  input Real y[:];
  output Real errorValue "Interpolated error";

protected
  Integer numberOfPoints;
  Integer rangeNumber;

equation
  numberOfPoints = size(y);

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
                                      (numberOfPoints-1)),
                          (numberOfPoints-1)),
                      1);
    errorValue = coefficients[rangeNumber, 1] +
                 coefficients[rangeNumber, 2] * u +
                 coefficients[rangeNumber, 3] * u^2 +
                 coefficients[rangeNumber, 4] * u^3;
  end if;

end SplineError;
