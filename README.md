# mailok-fg100

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
- [ ] First image on real hardware (waiting for Tang Nano 9K delivery)
- [ ] Framebuffer
- [ ] Sprites
- [ ] Pong

## Project structure
