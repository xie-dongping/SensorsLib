within SensorsLib.Generic.Errors;

model TestDeadBandError
  extends Modelica.Icons.Example;
  SensorsLib.Generic.Errors.DeadBandError deadBandError(deadBandLength = 5,
                                                        gain = 1, 
                                                        xDeadBandMiddle = 15,
                                                        yDeadBandMiddle = 15);
  Modelica.Blocks.Sources.Ramp ramp1(duration = 1, height = 10, offset = 10);
  Real outputValue;
equation
  deadBandError.u = ramp1.y;
  outputValue = ramp1.y + deadBandError.errorValue;
end TestDeadBandError;