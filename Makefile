HOSTNAME = $(shell hostname)
USERNAME = $(shell whoami)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error hostname unknown)
endif

ifndef USERNAME
 $(error username unknown)
endif

flake-update:
	nix flake update

nixos-switch:
	nixos-rebuild --flake .#${HOSTNAME} switch --use-remote-sudo --show-trace

nixos-boot:
	nixos-rebuild --flake .#${HOSTNAME} boot --use-remote-sudo --show-trace

nixos-test:
	nixos-rebuild --flake .#${HOSTNAME} test --use-remote-sudo --show-trace

nixos-upgrade:
	make flake-update && make nixos-switch

nixos-gc:
	sudo nix-collect-garbage

nixos-gc-d:
	sudo nix-collect-garbage -d

home-switch:
	home-manager --flake .#${USERNAME}@${HOSTNAME} switch --show-trace

home-upgrade:
	make flake-update && make home-switch

home-gc:
	nix-collect-garbage

home-gc-d:
	nix-collect-garbage -d
