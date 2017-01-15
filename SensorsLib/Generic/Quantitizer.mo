within SensorsLib.Generic;

model Quantitizer
  extends Modelica.Blocks.Interfaces.SISO;
  import Modelica.Blocks.Math.RealToInteger;
  import Modelica.Blocks.Math.IntegerToReal;

  parameter Real step = 0.01 "Step for quantization";
  RealToInteger realToInteger;
  IntegerToReal integerToReal;

equation
  realToInteger.u = u / step;
  integerToReal.u = realToInteger.y;
  y = integerToReal.u * step;
end Quantitizer;
