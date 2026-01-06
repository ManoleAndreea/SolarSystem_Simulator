# N-Body Solar System Simulation 🪐

![MATLAB](https://img.shields.io/badge/MATLAB-R2024b-orange) ![Simulink](https://img.shields.io/badge/Simulink-Model-blue) ![License](https://img.shields.io/badge/License-MIT-green)

## Overview
This project simulates the dynamics of the Solar System (Sun + 8 planets) using Newtonian mechanics. It implements the N-Body problem solution using two different approaches for validation:
1.  **Simulink Model:** Block-diagram simulation using standard integrators.
2.  **Numerical Integration (Script):** Custom implementation of the Runge-Kutta 4 (RK4) algorithm.

The simulation is validated against real-world ephemeris data provided by **NASA JPL Horizons**.

## Features
* 🌌 **N-Body Gravity Model:** Calculates the mutual gravitational influence of all 9 bodies.
* 🔄 **Retrograde Motion Analysis:** Visualizes the apparent retrograde motion of Mercury as seen from Earth.
* 📈 **Algorithm Comparison:** Benchmarks the Simulink solver against a custom RK4 fixed-step solver.
* 🎯 **Error Analysis:** Quantifies the integration error relative to JPL reference data over an 88-day period.

## Mathematical Model
The motion of each body $i$ is described by Newton's Law of Universal Gravitation:

$$m_{i}\ddot{r}_{i}(t) = \sum_{j=1, j\neq i}^{N} G m_{i}m_{j} \frac{r_{j}-r_{i}}{||r_{j}-r_{i}||^{3}}$$

Where:
* $r$ is the position vector.
* $G$ is the gravitational constant ($6.6743 \cdot 10^{-11} m^3 kg^{-1} s^{-2}$).

## Project Structure
* `src/` - Contains the initialization scripts, Simulink models (`.slx`), and RK4 implementation.
* `results/` - Generated plots and error reports.
* `assets/` - Visualization media (animations/screenshots).

## Getting Started

### Prerequisites
* MATLAB & Simulink (Version R2023b or newer recommended).

### Usage
1.  Clone the repository:
    ```bash
    git clone [https://github.com/ManoleAndreea/SolarSystem-Simulator.git](https://github.com/ManoleAndreea/SolarSystem-Simulator.git)
    ```
2.  Navigate to `src/` and run the initialization script to load NASA data:
    ```matlab
    init_solar_system
    ```
3.  Open and run the Simulink model `solar_system.slx` OR run the RK4 script `rk4_integrator.m`.

## Results & Visualizations
*(Placeholders for future GIFs/Plots - to be updated after simulation)*

* **3D Trajectories:** [Image placeholder]
* **Mercury's Retrograde Loop:** [Image placeholder]

## References
1.  NASA JPL Horizons System: https://ssd.jpl.nasa.gov/horizons/