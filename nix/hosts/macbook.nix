{ pkgs, ... }: {
	# Define the primary user (required for homebrew and system defaults)
	system.primaryUser = "eliaszeiner";
	# Define the user
	users.users.eliaszeiner = {
		name = "eliaszeiner";
		home = "/Users/eliaszeiner";
	};
	environment.systemPackages = [ pkgs.vim ];
	system.defaults.dock.autohide = true;
	# Disable nix-darwin's Nix management (for Determinate compatibility)
	nix.enable = false;
	homebrew = {
		enable = true;
		global.brewfile  = true;
		onActivation.cleanup = "uninstall";
		taps = [ "koekeishiya/formulae" ];
		brews = [ "cowsay" "wget" "koekeishiya/formulae/yabai" ];
		casks = [
		"zed"
		"zen"
		"raycast"
		"chatgpt"
		"pearcleaner"
		"aldente"
		"hyperkey"
		"protonvpn"
		"microsoft-outlook"
		];
		masApps = { };
	};
	services.yabai = {
		enable = true;

		config = {
			layout = "bsp";
			auto_balance = "on";
			split_ratio = "0.50";

			top_padding = 15;
			bottom_padding = 15;
			left_padding = 15;
			right_padding = 15;
			window_gap = 15;

			focus_follows_mouse = "autofocus";
			mouse_follows_focus = "off";
			mouse_modifier = "fn";
			mouse_action1 = "move";
			mouse_action2 = "resize";
		};

		extraConfig = ''
			yabai -m rule --add app="^FaceTime$" manage=off
			yabai -m signal --add event=window_focused action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
			yabai -m signal --add event=window_focused action="cliclick m:$(yabai -m query --windows --window | jq -r '[.frame.x + (.frame.w/2)|floor, .frame.y + (.frame.h/2)|floor] | @csv' | tr -d '\"')"
			yabai -m signal --add event=space_changed action="nohup open -g raycast://extensions/krzysztoff1/yabai/screens-menu-bar?launchType=background > /dev/null 2>&1 &"
		'';
	};
	# Set Git commit hash for darwin-rebuild
	system.stateVersion = 4;
}
