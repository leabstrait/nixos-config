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
	make update && make switch

hm-user-switch:
	home-manager --flake .#${USERNAME}@${HOSTNAME} switch --show-trace

nix-flake-update:
	nix flake update

nix-store-gc:
	nix store gc
