HOSTNAME = $(shell hostname)
USERNAME = $(shell whoami)

NIX_FILES = $(shell find . -name '*.nix' -type f)

ifndef HOSTNAME
 $(error hostname unknown)
endif

ifndef USERNAME
 $(error username unknown)
endif

nixos-host-switch:
	nixos-rebuild --flake .#${HOSTNAME} switch --use-remote-sudo --show-trace

nixos-host-boot:
	nixos-rebuild --flake .#${HOSTNAME} boot --use-remote-sudo --show-trace

nixos-host-test:
	nixos-rebuild --flake .#${HOSTNAME} test --use-remote-sudo --show-trace

nixos-host-upgrade:
	make nix-flake-update && make nixos-host-switch

nixos-collect-garbage:
	sudo nix-collect-garbage

nixos-collect-garbage-d:
	sudo nix-collect-garbage -d

hm-user-switch:
	home-manager --flake .#${USERNAME}@${HOSTNAME} switch --show-trace

hm-user-upgrade:
	make nix-flake-update && make hm-user-switch

hm-collect-garbage:
	nix-collect-garbage

hm-collect-garbage-d:
	nix-collect-garbage -d

nix-flake-update:
	nix flake update
