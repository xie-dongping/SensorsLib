within SensorsLib.Generic.Errors;

model DeadBandError
  "Calculate dead band error of the sensor using a polynomial"
  import SensorsLib.Generic.Errors.Functions.pureRandom;
  parameter Real gain;
  parameter Real xDeadBandMiddle = 0;
  parameter Real yDeadBandMiddle = 0;
  parameter Real deadBandLength;

  input Real u;
  output Real errorValue;

protected
  Real polynomialCoefficientOrder5 = - 16 * gain / deadBandLength^4;
  Real polynomialCoefficientOrder3 = 8 * gain / deadBandLength^2;
  Real deadBandOutput;
  Real sensorOriginalOutput;

  Real xDeadBandLeft = xDeadBandMiddle - deadBandLength / 2;
  Real xDeadBandRight = xDeadBandMiddle + deadBandLength / 2;

equation
  sensorOriginalOutput = yDeadBandMiddle + (u - xDeadBandMiddle) * gain;

  if (u < xDeadBandRight and u > xDeadBandLeft) then
    deadBandOutput = polynomialCoefficientOrder5 * (u - xDeadBandMiddle)^5 +
                     polynomialCoefficientOrder3 * (u - xDeadBandMiddle)^3 +
                     yDeadBandMiddle;
  else
    deadBandOutput = sensorOriginalOutput;
  end if;

  errorValue = deadBandOutput - sensorOriginalOutput;

end DeadBandError;
