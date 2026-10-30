# NixOS System Configuration

Declarative NixOS configuration and home-manager setup for personal machines.

## Language

**Host Constructor**:
The unified function in `flake.nix` that instantiates a NixOS system, binding baseline modules, home-manager defaults, and inputs behind a minimal interface.
_Avoid_: System builder, factory function, boilerplater

**Host Adapter**:
A machine-specific module (`hosts/<name>/default.nix`) providing hardware definitions, machine-unique drivers, and profile selections for that target system.
_Avoid_: Host config, host wrapper, machine file

**Desktop Module**:
The deep module (`modules/desktop`) encapsulating display servers, audio pipelines, session utilities, and environment adapters behind the `myDesktop.environment` option.
_Avoid_: Desktop manager, GUI configuration, windowing service

**User Seam**:
The declarative interface (`mySystem.user`) defining the primary user identity and binding system account privileges, groups, and home-manager configurations polymorphically.
_Avoid_: User profile, account config, user wrapper

**Feature Module**:
A domain-specific subsystem (`modules/dev`, `modules/gaming`) encapsulating package sets, background services, and kernel rules behind high-level boolean options.
_Avoid_: App bundle, package list, service wrapper
