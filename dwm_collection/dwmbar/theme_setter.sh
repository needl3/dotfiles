#!/bin/bash
chosen_theme=$1
if grep "# $chosen_theme #" DwmbarThemes.md;then
	# Parse complete block
	theme=$(sed -n "/# $chosen_theme/,/# $chosen_theme #/p" DwmbarThemes.md | head -n-2 | tail -n+3)

	echo "[+] Found theme: $chosen_theme , Applying"
	echo $theme > DwmbarThemes.h

	echo "[+] Reinstalling DWM for changes to take effect. Please authorize."
	cd ../dwm
	if sudo make clean install;then
		make clean
		cd ../dwmbar
		echo "[+] Restart DWM to render changes"
	else
		echo "[X] You didn't trust me. Reinstall DWM yourself, you sheep."
	fi
else
	echo "[X] No theme found with that name. Not applied."
fi