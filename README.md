# This is a WIP....


# Goal of The Project

* a open source library for detailed mechantronic sensors

# Compatibility Goal

Compiliance for Modelica 3.3 with MSL 3.2.2

# TODOs

* draft for basic architecture
    * input physical signals
    * output electric signals
    * D/A unit
* sensors generating eletric signals
    * electric sensor
    * magnetic sensor
    * piezo-eletrical sensor
* D/A Unit
    * Quantization
    * Emmiting Real Signals, with/without Events
    * implemtation using modelica synchronous
* Amplifiers
    * Simple
    * opamp
* additive noise
* mechanical sensors
    * translational
        * position
        * distance
        * force
    * rotational
        * angular velocity
        * angular acceleration
* generic (transfer function like) distortion sensor model

# Workflow:

* Each model should have a unit test test bench demonstrating its usage, and for the regression tests

# Model Development Guideline

* every model should be use encapsulated model
* line length less than 120
* all physical quantities must have a Type (be it in Modelica.SIUnits or not)

# Infrastructural Element

* Continues Integration Tests with Jenkins
* Supporting multiple compiler:
    * OpenModelica
    * MWorks
    * JModelica

# Backlogs
