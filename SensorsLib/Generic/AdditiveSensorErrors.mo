within SensorsLib.Generic;

model AdditiveSensorErrors
  extends Modelica.Blocks.Interfaces.SISO;

  import SensorsLib.Generic.Errors;

  parameter Real gain(unit="1", min=0) = 1 "The scaling function from input to output";
  parameter Real inputMax(unit="1") = 1 "Maximal sensor input";
  parameter Real inputMin(unit="1") = 0 "Minimal sensor input";
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

  Errors.CalibrationError calibrationError(gain=gain, inputMax=inputMax,
                                           inputMin=inputMin,
                                           errorMax=errorCalibration);
  Errors.HysteresisError hysteresisError(gain=gain, inputMax=inputMax,
                                         inputMin=inputMin,
                                         errorMax=errorHysteresis);
  Errors.NonlinearityError nonlinearityError(gain=gain, inputMax=inputMax,
                                             inputMin=inputMin,
                                             errorMax=errorNonlinearity);
  Errors.RepeatabilityError repeatabilityError(gain=gain, inputMax=inputMax,
                                               inputMin=inputMin,
                                               errorMax=errorRepeatability);
  Errors.DeadBandError deadBandError(gain=gain, deadBandLength=inputDeadBand/2);

equation
  deadBandError.u = u;
  calibrationError.u = u;
  hysteresisError.u = u;
  nonlinearityError.u = u;
  repeatabilityError.u = u;

  y = calibrationError.errorValue + deadBandError.errorValue +
      hysteresisError.errorValue + repeatabilityError.errorValue +
      nonlinearityError.errorValue;
end AdditiveSensorErrors;
