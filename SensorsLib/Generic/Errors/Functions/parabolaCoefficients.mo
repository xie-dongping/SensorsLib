within SensorsLib.Generic.Errors.Functions;

function parabolaCoefficients
  "Obtain the parabola coefficients with a fixed boundary condition"
  extends Modelica.Icons.Function;
  input Real xFree "x coordinate of the free end";
  input Real yFree "y coordinate of the free end";
  input Real xFixSlope "x coordinate of the end with fixed rate of change";
  input Real yFixSlope "y coordinate of the end with fixed rate of change";
  input Real slopeValue "The predefined rate of change at xFixSlope";
  output Real[3] coefficient "Parabola coefficients with ascending order";

protected
  Real coefficientOrder0;
  Real coefficientOrder1;
  Real coefficientOrder2;

algorithm
  coefficientOrder0 := (-xFree^2 * yFixSlope
                        - (xFree * (xFree - xFixSlope)
                           * (slopeValue * xFixSlope - 2 * yFixSlope))
                        + xFixSlope^2 * yFree)
                       / (xFree^2 - 2 * xFree * xFixSlope + xFixSlope^2);
  coefficientOrder1 := (slopeValue * xFree^2 - slopeValue * xFixSlope^2
                        - 2 * xFixSlope * yFree + 2 * xFixSlope * yFixSlope)
                       / (xFree^2 - 2 * xFree * xFixSlope + xFixSlope^2);
  coefficientOrder2 := (-slopeValue * xFree + slopeValue * xFixSlope
                        + yFree - yFixSlope)
                       / (xFree^2 - 2 * xFree * xFixSlope + xFixSlope^2);
  coefficient := {coefficientOrder0, coefficientOrder1,
                  coefficientOrder2};
end parabolaCoefficients;
