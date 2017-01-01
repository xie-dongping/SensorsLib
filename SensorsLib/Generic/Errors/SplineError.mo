within SensorsLib.Generic.Errors;

encapsulated model SplineError

  constant Integer numberOfCoeffients = 4;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Integer numberOfPoints;

  input Real u;
  input Real coefficients[numberOfPoints-1, numberOfCoeffients];
  input Real y[numberOfPoints];
  output Real errorValue "Interpolated error";

protected
  Integer rangeNumber;

equation
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
