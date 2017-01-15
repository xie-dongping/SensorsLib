within SensorsLib.Generic;

model LinearSensor
  extends Modelica.Blocks.Interfaces.SISO;

  import Modelica.SIunits;
  import Modelica.Blocks.Continuous.FirstOrder;
  import Modelica.Blocks.Nonlinear.Limiter;
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

  FirstOrder sensorDynamics(T=timeConstant);
  Limiter inputLimitation(uMax=inputMax, uMin=inputMin);

  AdditiveSensorErrors sensorErrors(gain=gain, inputMax=inputMax,
                                    inputMin=inputMin,
                                    errorCalibration=errorCalibration,
                                    errorHysteresis=errorHysteresis,
                                    errorRepeatability=errorRepeatability,
                                    inputDeadBand=inputDeadBand)
    annotation(Placement(visible = true, transformation(origin = {-70, 2})));

end LinearSensor;
