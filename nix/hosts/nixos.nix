{ pkgs, ... }: {
	# Boot loader
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Hardware - you'll need to generate this
	imports = [ ./hardware-configuration.nix ];

	# Networking
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

	# Time zone
	time.timeZone = "America/New_York";

	# Users
	users.users.elias = {
			isNormalUser = true;
			extraGroups = [ "wheel" "networkmanager" ];
			packages = [];
		};

	# Enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# System packages
	environment.systemPackages = with pkgs; [
		vim
		git
	];

	system.stateVersion = "24.05"; # Check current version
}
