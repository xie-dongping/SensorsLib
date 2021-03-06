within SensorsLib.Generic.Errors;

model TestRepeatabilityError
  extends Modelica.Icons.Example;
  SensorsLib.Generic.Errors.RepeatabilityError repeatabilityError(errorMax = 0.5, gain = 1, inputMax = 20, inputMin = 10);
  Modelica.Blocks.Sources.Sine sine1(amplitude = 4, freqHz = 1, offset = 10, phase = -1.5708, startTime = 1);
equation
  repeatabilityError.u = sine1.y;
end TestRepeatabilityError;