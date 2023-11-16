# HanoiTowersABBRobot

Implementation of a solution to the **Hanoi Towers Problem** using an **ABB robot** (*IRB120_3_58*) and programmed in **RAPID language** using **recursion**, for the robot programming subject of my robotics MSc.

<p align="center">
  <img src="https://github.com/asierzd/HanoiTowersABBRobot/blob/main/imgs/HanoiTowers.png" alt="Hanoi Towers model">
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/asierzd/HanoiTowersABBRobot?label=License&style=for-the-badge&color=yellow" href="https://opensource.org/license/gpl-3-0/"/>
  <img src="https://img.shields.io/github/languages/top/asierzd/HanoiTowersABBRobot?style=for-the-badge&color=green"/>
</p>

## Dependencies
- ABB RobotStudio 2023.2 version.
- ABB RobotStudio premium license (there is a month trial for free).
- RobotWare 6.10.01

## Implementation
- Tool with the geometry provided by RobotStudio.
- Intelligent tool 'MiAspiradorTool', for the Pick and Place of the disks, as a vacuum gripper tool.
- Station logic, creating the necessary digital signals to communicate the robot controller and our intelligent tool. 
- Hanoi Towers problem implemented using *recursion*, available in the **'Module1.mod'** file.

## Intelligent Tool

- **Intelligent tool components and logic**: I have developed with geometry the piece with a cone, two cylinders and performed the subtraction operation in order to have a small hole in the tip to simulate the shape of the vacuum gripper. Then, it has to be used this piece to create a tool, and with this new tool, it has to be used for creating the smart component, with a **Line Sensor** for detecting the disks, an **Attacher** for holding the disks, a **NOT Logic Gate**, an **Dettacher** for placing the disks on each tower, and a **Logic SR Latch**, as you can see in the following figure.

<p align="center">
  <img src="https://github.com/asierzd/HanoiTowersABBRobot/blob/main/imgs/IntelligentToolPickAndPlace.png" alt="Intelligent Tool">
</p>

- **Station logic**: In order to be able to communicate our intelligent tool (the vacuum gripper), we need to communicate them using signals, it is needed to create at least two signals in our controller, **holding** as a *Digital Input*, and **hold** as a *Digital Output*, which will be connected as follows in the next figure with the input and output of the intelligent tool.

<p align="center">
  <img src="https://github.com/asierzd/HanoiTowersABBRobot/blob/main/imgs/StationLogic.png" alt="Station Logic">
</p>

## RAPID Program

