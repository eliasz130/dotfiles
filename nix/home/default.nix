{ pkgs, ... }:
{
	home.username = "eliaszeiner";
	home.homeDirectory = "/Users/eliaszeiner";
	home.stateVersion = "24.05";

	home.packages = with pkgs; [
		htop
		fzf
		nixd
		zsh
		qbittorrent
	];

	programs.git = {
		enable = true;
		userName = "eliasz130";
		userEmail = "eliaspublic@icloud.com";
	};

	# Let home-manager manage itself
	programs.home-manager.enable = true;
	home.sessionVariables = {
    HOMEBREW_FORCE_VENDOR_RUBY = "1";
	};
}
