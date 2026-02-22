# Final group project - Digital Systems Laboratory

## Students:
* Felipe Santos Souza
* Felipe Cabello Russo Magalhães Silva


## Motivation

Elevator systems rely on hardware-based models so they can function in a fast and efficient manner. Among the various implementations available, hardware description languages (HDLs) provide a simple and cost-efficient manner of creating robust and great solutions.

This project was made as a simple solution to a 2 floor elevator system, while allowing room for modifications and / or improvements.


## Description

The group of students utilized the VHSIC Hardware Description Language (VHDL) to build a functioning and efficient elevator RTL project. 

It began by identifying the desired behaviour of the Finite-State Machine at a high level.

Then the datapath was created, based on the previous phase.

After that, the controller - implemented as a FSM - was integrated to the datapath to manage system states and transitions.

# Project Overview

A detailed report containing a full resume, datapath, FSM diagrams, datapath design, and codes can be found on the [following PDF](https://drive.google.com/file/d/1JdELvtcFngySivSQE9XqNvHbtnS0ab5T/view?usp=sharing). The full [simulation](https://www.youtube.com/watch?v=5AMN9yaZBxU) and [personal notes](https://www.youtube.com/watch?v=qpHbyG8TAZY) were recorded and posted on youtube.


## Architecture

The system follows a controller–datapath structure:

- **Controller (FSM):** Responsible for managing states and transitions.
- **Datapath:** Handles signal processing and output logic.
- **Top Module:** Connects controller and datapath.



---

## Finite-State Machine (FSM)

The controller is implemented as a Moore/Mealy FSM.

### States

- `S0` – Elevator starting
- `S1` – Elevator without movement
- `S2` – Elevator in movement
- `S3` – It reached the desired floor
- `S4` - Emergency state, elevator goes back to the first floor

State transitions depend on floor requests and current position.

---

## Inputs



---

## Outputs



## Simulation

The system was verified through simulation using [Tool Name].

The testbench validates:

- State transitions
- Correct response to floor requests
- Proper output activation

[Insert waveform screenshot if available]

---

## Tools Used

- VHDL
- Quartus II
- RTL Design Methodology

---

## Future Improvements

- Extend to multiple floors
- Implement request prioritization
- Add timing constraints
- FPGA deployment and hardware validation