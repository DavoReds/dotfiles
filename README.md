# My Dotfiles

Here are all the configuration files for all the programs I use. My config is done using [home-manager](https://nix-community.github.io/home-manager/), which can be installed even on non NixOS systems, so maybe take a look at it. If you do not wish to use home-manager, there are still a couple programs configured externally, so you can copy and paste if you want.

## Non Home-Manager

These are all the programs that are not defined in a nix file and therefore can be copy pasted without issues:

1. dprint
2. nbfc
3. Neovim
4. SQLite
5. Swappy
6. [Tasker-cli](https://github.com/DavoReds/tasker)
7. Tmux

## Home-Manager

These are all the programs that are configured using home-manager modules, and therefore need this program to use the configuration:

1. Alacritty
2. Amberol
3. Bat
4. Btop
5. Cliphist
6. Eza
7. FZF
8. Git
9. Gitui
10. Helix
11. Hyprland
12. Hyprpaper*
13. Hypridle*
14. Jujutsu
15. Lazygit
16. LF (additional icon file required and provided in the repo)
17. Mako
18. MPD
19. MPV
20. ncmpcpp
21. ncspot
22. password-store
23. Remmina
24. Swaylock
25. Starship
26. Tofi
27. Topgrade
28. Waybar
29. Zathura
30. Zoxide
31. Zsh

\* These programs are configured in my `home.nix` configuration file instead of their own module because having so many programs to make Hyprland usable annoys me and I didn't have the energy to modularize them.

---

Because I'm a NixOS user, this repo contains many more files and configurations that are specific to my setup and my machines. You are welcome to look them up if you're interested, but use them at your own risk.
