# My Dotfiles

Here are all the configuration files for all the programs I use. My config is done using [home-manager](https://nix-community.github.io/home-manager/), which can be installed even on non NixOS systems, so maybe take a look at it. If you do not wish to use home-manager, there are still a couple programs configured externally, so you can copy and paste if you want.

## Non Home-Manager

These are all the programs that are not defined in a nix file and therefore can be copy pasted without issues:

1. dprint
2. SQLite
3. nbfc
4. Tmux
5. [Tasker-cli](https://github.com/DavoReds/tasker)
6. Neovim
7. Swappy

## Home-Manager

These are all the programs that are configured using home-manager modules, and therefore need this program to use the configuration:

1. Bat
2. Eza
3. FZF
4. Git
5. Helix
6. Jujutsu
7. LF (additional icon file required and provided in the repo)
8. MPD
9. ncmpcpp
10. ncspot
11. password-store
12. Starship
13. Topgrade
14. Zoxide
15. Zsh

---

Because I'm a NixOS user, this repo contains many more files and configurations that are specific to my setup and my machines. You are welcome to look them up if you're interested, but use them at your own risk.
