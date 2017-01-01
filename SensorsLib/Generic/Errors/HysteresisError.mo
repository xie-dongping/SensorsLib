within SensorsLib.Generic.Errors;

encapsulated model HysteresisError
  "Nonlinearity calibration error of the sensor"

  import SensorsLib.Generic.Errors.pureRandom;
  import SensorsLib.Generic.Errors.parabolaCoefficients;
  import SensorsLib.Generic.Errors.parabolicHysteresis;
  import Modelica.SIunits.Time;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Time timeHysteresis;
  parameter Boolean ascendingOnTheLeft = true
    "If true, take the left curve when u is ascending";
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  input Real u;
  output Real errorValue(start=0) "Hysteresis error value in operating range";


protected
  constant Integer numberOfCoeffients = 3;
  Real hysteresisError;
  Real coefficientsLeft[2, numberOfCoeffients];
  Real coefficientsRight[2, numberOfCoeffients];

  Real yMin = 0 "Assume the a zero sensor output at inputMin";
  Real yMax = gain * (inputMax - inputMin);
  Real yMiddle = gain * (inputMax - inputMin) / 2;
  Real yNow;

  Real xMiddle = inputMin + (inputMax - inputMin) / 2;
  Real xHysteresisLeft, xHysteresisRight;

  Real leftHysteresis, rightHysteresis, targetError;
  Boolean ascending;

equation
  hysteresisError = pureRandom(localSeed, globalSeed, 0, errorMax);
  xHysteresisLeft = xMiddle - abs(gain) * hysteresisError / 2;
  xHysteresisRight = xMiddle + abs(gain) * hysteresisError / 2;

  coefficientsLeft[1, :] = parabolaCoefficients(inputMin, yMin,
                                                xHysteresisLeft,
                                                yMiddle, gain);
  coefficientsLeft[2, :] = parabolaCoefficients(inputMax, yMax,
                                                xHysteresisLeft,
                                                yMiddle, gain);
  coefficientsRight[1, :] = parabolaCoefficients(inputMin, yMin,
                                                 xHysteresisRight, yMiddle,
                                                 gain);
  coefficientsRight[2, :] = parabolaCoefficients(inputMax, yMax,
                                                 xHysteresisRight, yMiddle,
                                                 gain);

  leftHysteresis = parabolicHysteresis(u, xHysteresisLeft, coefficientsLeft);
  rightHysteresis = parabolicHysteresis(u, xHysteresisRight,
                                        coefficientsRight);

  der(errorValue) = 1 / timeHysteresis * (targetError - errorValue);
  yNow = gain * (u - inputMin);

  ascending = der(u) > 0;

  if initial() or u < inputMin or u >= inputMax then
    targetError = 0;
  elseif (ascending and ascendingOnTheLeft) then
    targetError = leftHysteresis - yNow;
  else
    targetError = rightHysteresis - yNow;
  end if;

end HysteresisError;
