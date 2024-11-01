USERNAME	=bocal
HOST		=nixos

NIX_FLAGS	= --extra-experimental-features "nix-command flakes"
NIXOS_FLAGS	= --cores 4
HOME_FLAGS	=

all: flake.lock switch home

lock: flake.lock

flake.lock:
	nix $(NIX_FLAGS) flake lock

update: flake.lock
	nix $(NIX_FLAGS) flake update

test:
	git add .
	sudo nixos-rebuild $(NIXOS_FLAGS) test --flake .#$(HOST)

switch:
	git add .
	sudo nixos-rebuild $(NIXOS_FLAGS) switch --flake .#$(HOST)

boot:
	git add .
	sudo nixos-rebuild $(NIXOS_FLAGS) boot --install-bootloader --flake .#$(HOST)

home:
	git add .
	home-manager $(HOME_FLAGS) --flake .#$(USERNAME)@$(HOST) switch

PHONY: all lock update test switch boot home
