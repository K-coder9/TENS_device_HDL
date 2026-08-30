<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

The module takes in a speed selection input and pulse duration then changes the frequency of the electrical impulses being generated. This project just demonstrates how a digital method can control the pulses through a PWM generator however in reality TENs devices are complicated and involve many more components outside of a digital pulse controller.

## How to test

Run the testbench files found in test folder. The duty_ratio test sets a random number for the dp and compares the signal generated to the requested input. 

The project passes prechecks.

