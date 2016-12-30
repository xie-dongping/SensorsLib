within SensorsLib.Generic.Errors;

model TestNolinearityError
  extends Modelica.Icons.Example;
  SensorsLib.Generic.Errors.NonlinearityError nonlinearityError1(errorMax = 0.5, gain = 1, inputMax = 20, inputMin = 10)  annotation(
    Placement(visible = true, transformation(origin = {-2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp1(duration = 1, height = 10, offset = 10)  annotation(
    Placement(visible = true, transformation(origin = {-38, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  nonlinearityError1.u = ramp1.y;
end TestNolinearityError;