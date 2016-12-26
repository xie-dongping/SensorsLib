within SensorsLib.Generic.Errors;

function pureRandom "Generate a random number in a pure fashion"
  extends Modelica.Icons.Function;

  import Modelica.Math.Random.Generators.Xorshift1024star.random;
  import Modelica.Math.Random.Generators.Xorshift1024star.initialState;  
  input Integer localSeed "Local seed for the random number generator";
  input Integer globalSeed "Global seed for the random number generator";
  input Real minValue = 0;
  input Real maxValue = 1;
  output Real randomValue "Uniform random value from 0 to 1";
  
protected
  Integer state1024[33];
  Real generatedRandomValue;  
algorithm
  state1024 := initialState(localSeed, globalSeed);
  (generatedRandomValue, state1024):= random(state1024);
  randomValue := minValue + (maxValue - minValue) * generatedRandomValue;
end pureRandom;
