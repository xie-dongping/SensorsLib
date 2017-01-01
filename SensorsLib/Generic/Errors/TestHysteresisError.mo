within SensorsLib.Generic.Errors;

model TestHysteresisError
  extends Modelica.Icons.Example;
  SensorsLib.Generic.Errors.HysteresisError hysteresisError(errorMax = 0.5, gain = 1, inputMax = 20, inputMin = 10, timeHysteresis = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Modelica.Blocks.Sources.Sine sine1(amplitude = 4, freqHz = 1, offset = 10, phase = -1.5708)  annotation(
    Placement(visible = true, transformation(origin = {-48, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  hysteresisError.u = sine1.y;
end TestHysteresisError;
