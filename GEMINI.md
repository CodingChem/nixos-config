# NixOS Configuration Project Guidelines

This file defines the structural and architectural mandates for this NixOS configuration.

## Project Structure

The project follows a strict host-centric and modular structure:

- `/flake.nix`: Entry point. Must remain simple, primarily orchestrating host definitions by loading `/hosts/{host}/default.nix`.
- `/hosts/`: Contains system-specific configurations.
    - `/{host}/default.nix`: Main system configuration for a specific host.
    - `/{host}/hardware-configuration.nix`: Hardware-specific settings (typically generated).
    - `/{host}/home.nix`: Host-specific Home Manager configuration.
- `/modules/`: Contains shared configurations.
    - `/home/default.nix`: Shared Home Manager modules and configurations.
    - `/shared/default.nix`: Shared NixOS settings (e.g., locale, core packages, nix settings).

## Core Mandates

1. **Keep it Simple:** Avoid over-engineering. Favor readability and standard Nix patterns over complex custom abstractions.
2. **Tidy Modules:** Logic should be logically grouped. System-wide defaults go in `/modules/shared`, while user-specific logic goes in `/modules/home` or host-specific `home.nix`.
3. **Home Manager Integration:** Prepare for Home Manager inclusion. All user-level configurations should eventually transition to Home Manager modules.
4. **Declarative First:** Ensure all configurations are declarative and reproducible. Avoid imperative hacks.
