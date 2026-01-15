{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.flavor = "macchiato";
  catppuccin.enable = true;

  # User setup
  home.username = "vegard";
  home.homeDirectory = "/home/vegard";
  home.stateVersion = "25.11";

  # Apps
  home.packages = with pkgs; [
    fzf
    ripgrep
    fd
    bat
    eza
    obsidian
    devenv
    tmux
    # Nix LSP and Formatter
    nil # The standard Language Server for Nix
    nixpkgs-fmt # The formatter used in the config above
    libnotify

    # Bash/Shell LSP
    nodePackages.bash-language-server
    shellcheck # Lints your shell scripts (Helix uses this automatically)
  ];
  # program settings
  programs = {
    home-manager.enable = true;

    kitty = {
      enable = true;
      settings = {
        font_family = "JetbrainsMono Nerd Font";
        font_size = 14;
        background_opacity = "0.9";
        window_padding_width = 10;
        enable_audio_bell = false;
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
      };
      gitCredentialHelper = {
        enable = true;
      };
    };

    # Zsh konfigurasjon
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        nos = "sudo nixos-rebuild switch --flake ~/.config/nixos";
        ls = "eza --icons";
        ll = "eza --icons -l";
        la = "eza --icons -la";
        lt = "eza --icons --git-ignore --tree";
        cat = "bat";
      };
    };

    # Oh-my-posh med Catppuccin tema
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      # Vi bruker Catppuccin Mocha her
      useTheme = "catppuccin_mocha";
    };

    # Fzf integrasjon
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    neovim = {
      enable = true;
      defaultEditor = false;
    };

    git = {
      enable = true;
      settings = {
        user = {
          name = "Vegard Pareli Seines";
          email = "vegsei@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
    helix = {
      enable = true;

      # Set it as the default editor (optional, overrides $EDITOR)
      defaultEditor = true;

      settings = {
        editor = {
          line-number = "relative"; # Essential for jumping (e.g., 5j, 10k)
          mouse = false; # Keep hands on keyboard (cleaner in dwm)
          cursorline = true; # Highlight the current line
          bufferline = "multiple"; # Show open buffers (tabs) at the top
          true-color = true; # Utilize your GPU for proper colors

          # Visual feedback for modes
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          # cleanly render whitespace (optional but useful for coding)
          whitespace.render = {
            space = "none";
            tab = "all";
            newline = "none";
          };

          # Minimalist status line config
          statusline = {
            left = [ "mode" "spinner" ];
            center = [ "file-name" ];
            right = [ "diagnostics" "selections" "position" "file-encoding" "file-line-ending" "file-type" ];
            separator = "│";
          };

          # File picker (space + f) configuration
          file-picker = {
            hidden = false; # Do not show hidden files by default
          };
        };

        # "Sensible" Keymaps
        keys.normal = {
          "C-s" = ":w"; # Ctrl+s to save
          "esc" = [ "collapse_selection" "keep_primary_selection" ]; # Make Esc clear multi-cursors
        };
      };

      # Language Configuration (For your Scripts & Nix config)
      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = { command = "nixpkgs-fmt"; };
          }
          {
            name = "bash";
            auto-format = true;
            # indent-style = "space"; # Optional: force spaces over tabs
          }
        ];
      };
    };
  };
  services.dunst = {
    enable = true;

    settings = {
      global = {
        # Appearance
        width = 300;
        height = 100;
        origin = "top-right"; # Where it pops up
        offset = "10x50"; # Move it down slightly (avoids the dwm bar)

        font = "Monospace 10";

        # Icons (Important for your Flatpak apps)
        icon_position = "left";
        max_icon_size = 64;

        # Behavior
        browser = "firefox -new-tab"; # Or your preferred browser
        dmenu = "dmenu -p dunst:";

        # Formatting
        format = "<b>%s</b>\\n%b"; # Bold summary, normal body
      };

      # Theming (Catppuccin Mocha style to match your Helix config)
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
      };

      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#89b4fa";
      };

      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#f38ba8"; # Red for errors
        frame_color = "#f38ba8";
        timeout = 0; # Critical notifications stay until clicked
      };
    };
  };
}
