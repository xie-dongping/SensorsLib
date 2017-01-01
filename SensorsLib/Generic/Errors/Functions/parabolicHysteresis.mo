within SensorsLib.Generic.Errors;

function parabolicHysteresis
  extends Modelica.Icons.Function;
  input Real u;
  input Real uTransition;
  input Real[2, 3] coefficients "Parabola coefficients with ascending order";
  output Real curveValue;

algorithm
  if u < uTransition then
    curveValue := coefficients[1, 1] + coefficients[1, 2] * u +
                  coefficients[1, 3] * u^2;
  else
    curveValue := coefficients[2, 1] + coefficients[2, 2] * u +
                  coefficients[2, 3] * u^2;
  end if;
end parabolicHysteresis;
