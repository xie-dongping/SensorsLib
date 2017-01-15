within SensorsLib.Generic;

model TestLinearSensor
  extends Modelica.Icons.Example;
  LinearSensor linearSensor1 annotation(
    Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Sine sine1(amplitude = 1.05, freqHz = 1)  annotation(
    Placement(visible = true, transformation(origin = {-70, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sine1.y, linearSensor1.u) annotation(
    Line(points = {{-58, 2}, {-12, 2}, {-12, 2}, {-12, 2}}, color = {0, 0, 127}));

end TestLinearSensor;