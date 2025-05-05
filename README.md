# Signed_spm

# 🔢 8x8 Serial-Parallel Multiplier (SPM) on Basys 3

This project implements an **8-bit signed Serial-Parallel Multiplier (SPM)** using Verilog on the **Basys 3 FPGA (Artix-7)**. It provides a hardware-efficient balance between speed and simplicity by processing one operand serially and the other in parallel.

## 🛠️ Features

- **Inputs via Toggle Switches:**
  - `SW7–SW0` → 8-bit signed **Multiplier**
  - `SW15–SW8` → 8-bit signed **Multiplicand**

- **Start Multiplication:**
  - Press `BTNC` to begin the multiplication process.

- **Output Display:**
  - The **right 3 digits** of the 7-segment display show the decimal product.
  - The **leftmost digit** displays the **sign**.
  - Use:
    - `BTNL` to scroll left
    - `BTNR` to scroll right

- **End of Operation:**
  - `LD0` LED lights up to indicate completion.

## 📟 Hardware & Tools

- **FPGA Board:** Basys 3 (Artix-7)
- **Language:** Verilog
- **Toolchain:** Vivado Design Suite

# 🚀 How to Use

1. Clone the repository:

git clone https://github.com/omarramy22/Signed_spm.git

2. Open the project in **Vivado**.
3. Add the XDC file and source files.
4. Synthesize and generate bitstream.
5. Load onto the Basys 3 board.
6. Use switches and buttons as described above.
