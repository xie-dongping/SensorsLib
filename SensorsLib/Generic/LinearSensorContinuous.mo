within SensorsLib.Generic;

model LinearSensorContinuous
  extends Modelica.Blocks.Interfaces.SISO;

  import Modelica.SIunits;
  import SensorsLib.Generic.AdditiveSensorErrors;

  parameter Real gain(unit="1", min=0) = 1 "The scaling function from input to output";
  parameter Real inputMax(unit="1") = 1 "Maximal sensor input";
  parameter Real inputMin(unit="1") = 0 "Minimal sensor input";
  parameter SIunits.Time timeConstant = 0.001
    "Time constant for sensor response";
  parameter Real errorCalibration(unit="1", min=0) = 0.1
    "Maximum calibration error for two point calibration";
  parameter Real errorNonlinearity(unit="1", min=0) = 0.1
    "Maximum nonlinearity error";
  parameter Real errorHysteresis(unit="1", min=0) = 0.1
    "Maximum hystersis error";
  parameter Real errorRepeatability(unit="1", min=0) = 0.1
    "Maximum repeatablity error";
  parameter Real inputDeadBand(unit="1", min=0) = 0.04
    "Dead band length";

  AdditiveSensorErrors sensorErrors(gain=gain, inputMax=inputMax,
                                    inputMin=inputMin,
                                    errorCalibration=errorCalibration,
                                    errorHysteresis=errorHysteresis,
                                    errorNonlinearity=errorNonlinearity,
                                    errorRepeatability=errorRepeatability,
                                    inputDeadBand=inputDeadBand)
    annotation(Placement(visible = true, transformation(origin = {42, 30},
               extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder sensorDynamics(T = timeConstant)  annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter inputLimitation(uMax = inputMax, uMin = inputMin)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(sensorDynamics.y, add.u2) annotation(
    Line(points = {{12, 0}, {20, 0}, {20, -4}, {66, -4}, {66, -6}, {68, -6}}, color = {0, 0, 127}));
  connect(sensorErrors.y, add.u1) annotation(
    Line(points = {{54, 30}, {60, 30}, {60, 6}, {68, 6}, {68, 6}}, color = {0, 0, 127}));
  connect(add.y, y) annotation(
    Line(points = {{91, 0}, {110, 0}}, color = {0, 0, 127}));
  connect(inputLimitation.u, u) annotation(
    Line(points = {{-62, 0}, {-110, 0}, {-110, 0}, {-120, 0}}, color = {0, 0, 127}));
  connect(sensorDynamics.u, inputLimitation.y) annotation(
    Line(points = {{-12, 0}, {-40, 0}, {-40, 0}, {-38, 0}}, color = {0, 0, 127}));
  connect(sensorErrors.u, sensorDynamics.y) annotation(
    Line(points = {{30, 30}, {20, 30}, {20, 0}, {12, 0}}, color = {0, 0, 127}));
end LinearSensorContinuous;
