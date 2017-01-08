within SensorsLib.Generic.Errors;

model RepeatabilityError
  "Repeatability error of the sensor"

  import SensorsLib.Generic.Errors.Functions.pureRandom;
  import SensorsLib.Generic.Errors.LorenzSystem;
  import Modelica.SIunits.Time;

  parameter Real gain;
  parameter Real inputMax;
  parameter Real inputMin;
  parameter Real errorMax;
  parameter Time timeConstant;
  parameter Integer numberOfPoints = 6;
  parameter Integer localSeed = 41234;
  parameter Integer globalSeed = 3124;

  input Real u;
  output Real errorValue "Nonlinearity error value in operating range";

  LorenzSystem lorenzSystem;

protected
  Real normalizedInput;
  Real derInput;
  Real stateDT1;
  Real xRangeInitial = lorenzSystem.stateRadius / 2; // safety factor 2
  Real zValueInitial = lorenzSystem.a + lorenzSystem.c;

initial equation
  lorenzSystem.x = pureRandom(localSeed, globalSeed, -xRangeInitial,
                              xRangeInitial);
  lorenzSystem.y = 0;
  lorenzSystem.z = 0;

equation
  normalizedInput = (u - inputMin) / (inputMax - inputMin);
  der(stateDT1) = normalizedInput - timeConstant * stateDT1;
  derInput = abs(der(stateDT1));
  lorenzSystem.derTime = derInput;
  errorValue = lorenzSystem.x * errorMax / lorenzSystem.stateRadius;

end RepeatabilityError;
