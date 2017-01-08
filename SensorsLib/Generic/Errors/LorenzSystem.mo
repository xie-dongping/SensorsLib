within SensorsLib.Generic.Errors;

encapsulated model LorenzSystem
  "A chaotic Lorenz system with time derivative as input"

  parameter Real a = 10;
  parameter Real b = 8 / 3;
  parameter Real c = 28;
  input Real derTime;
  Real x;
  Real y;
  Real z;
  Real stateRadius;

protected
  Real derX;
  Real derY;
  Real derZ;

equation
  if (a >= 1 and b >= 2) then
    stateRadius = sqrt((a + c)^2 * b^2 / 4 / (b - 1));
  elseif (b < 2) then
    stateRadius = abs(a + c);
  else
    stateRadius = sqrt((a + c)^2 * b^2 / 4 / (b - a));
  end if;

  derX = a * (y - x);
  derY = c * x - x * z - y;
  derZ = x * y - b * z;
  der(x) = derX * derTime;
  der(y) = derY * derTime;
  der(z) = derZ * derTime;
end LorenzSystem;
