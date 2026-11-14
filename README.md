# mailok-fg110

A homebrew FPGA-based graphics card project. Built from scratch on the Sipeed Tang Nano 9K (Gowin GW1NR-9 FPGA).

## Goal

Build a working graphics card on FPGA that can:
- Generate HDMI/VGA signal
- Store frames in a framebuffer (8 MB PSRAM)
- Draw sprites and tilemaps
- Run simple 2D games (Pong, platformers)

## Status

- [x] Blink LED (simulation)
- [x] VGA/HDMI timing generator (simulation)
- [x] Test pattern (color bars, simulation)
- [x] Framebuffer implementation (`frame_buffer.v`)
- [x] Color palette implementation (`color_palette.v`)
- [ ] Framebuffer simulation (currently facing syntax errors in VeriSim)
- [ ] First image on real hardware (waiting for Tang Nano 9K delivery)
- [ ] Sprites
- [ ] Pong

## Known Issues

- **Simulation Error (VeriSim/Icarus):** The `top.v` module (integrating `frame_buffer` and `color_palette`) currently fails to compile in VeriSim with `Invalid module item` syntax errors around lines 165-173. The code is syntactically correct standard Verilog, but might be hitting an Icarus Verilog quirk or hidden character issue. Investigating.
