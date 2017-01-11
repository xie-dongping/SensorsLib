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
  parameter Time timeConstant = 0.01;
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
  Real rangeInitial = lorenzSystem.stateRadius / 2; // with safety reserve
  Real zValueInitial = lorenzSystem.a + lorenzSystem.c;

initial equation
  lorenzSystem.x = pureRandom(localSeed, globalSeed, -rangeInitial,
                              rangeInitial);
  lorenzSystem.y = pureRandom(localSeed*2, globalSeed, -rangeInitial,
                              rangeInitial);
  lorenzSystem.z = zValueInitial + pureRandom(localSeed*3, globalSeed,
                                              -rangeInitial, rangeInitial);

equation
  normalizedInput = (u - inputMin) / (inputMax - inputMin);
  der(stateDT1) = normalizedInput - timeConstant * stateDT1;
  derInput = abs(der(stateDT1));
  lorenzSystem.derTime = derInput;
  errorValue = lorenzSystem.x * errorMax / lorenzSystem.stateRadius;

end RepeatabilityError;
