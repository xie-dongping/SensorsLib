within SensorsLib.Generic.Errors;

function splineCoefficients
  "Obtain the cubic spline coefficients with zero-value boundary differetial"
  extends Modelica.Icons.Function;
  input Real xLeft;
  input Real yLeft;
  input Real xRight;
  input Real yRight;
  output Real[4] coefficient;

protected
  Real coefficientOrder0;
  Real coefficientOrder1;
  Real coefficientOrder2;
  Real coefficientOrder3;

algorithm
  coefficientOrder0 := (xLeft^3 * yRight - 3 * xLeft^2 * xRight * yRight +
                        3 * xLeft * xRight^2 * yLeft - xRight^3 * yLeft)
                       / (xLeft^3 - 3 * xLeft^2 * xRight +
                          3 * xLeft * xRight^2 - xRight^3);
  coefficientOrder1 := -6 * xLeft * xRight * (yLeft - yRight)
                       / (xLeft^3 - 3 * xLeft^2 * xRight +
                          3 * xLeft * xRight^2 - xRight^3);
  coefficientOrder2 := 3 * (xLeft * yLeft - xLeft * yRight +
                            xRight * yLeft - xRight * yRight)
                       / (xLeft^3 - 3 * xLeft^2 * xRight +
                          3 * xLeft * xRight^2 - xRight^3);
  coefficientOrder3 := (-2 * yLeft + 2 * yRight)
                       / (xLeft^3 - 3 * xLeft^2 * xRight +
                          3 * xLeft * xRight^2 - xRight^3);
  coefficient := {coefficientOrder0, coefficientOrder1,
                  coefficientOrder2, coefficientOrder3};
end splineCoefficients;
