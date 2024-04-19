if [ "$(id -u)" -ne 0 ]; then
    echo 'Run as a root' >&2
    exit 1
fi

RADEON_BUS_ID=$(lspci | grep Radeon | awk '{print $1}' | cut -c1-5)
NVIDIA_BUS_ID=$(lspci | grep GeForce | awk '{print $1}' | cut -c1-5)

COMMON_XORG_FILE_CONTENT='
Section "InputDevice"
    # generated from default
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5 6 7"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

'

AMD_SERVER_LAYOUT='
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "AMD"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

'

AMD_VIDEO_DEVICE_ENTRY="
Section \"Monitor\"
	Identifier \"AMD\"
	VendorName \"Lenovo\"
	ModelName  \"Legion5120Hz\"
EndSection

Section \"Screen\"
    Identifier     \"AMD\"
    Device         \"AMD\"
    Monitor	   \"AMD\"
    DefaultDepth    24
    Option	    \"TearFree\"			\"true\"
    Option	    \"VariableRefresh\"		\"true\"
    #Option	    \"AsyncFlipSecondaries\"	#[<bool>]
    #Option	    \"DRI3\"			#[<bool>]
    #Option	    \"DRI\"			#[<i>]
EndSection

Section \"Device\"
    Identifier     \"AMD\"
    Driver         \"amdgpu\"
    VendorName     \"Advanced Micro Devices\"
    BusID          \"PCI:$RADEON_BUS_ID:0\"
EndSection

"

NVIDIA_SERVER_LAYOUT='
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "NVIDIA"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

'

NVIDIA_VIDEO_DEVICE_ENTRY="
Section \"Monitor\"
	Identifier \"NVIDIA\"
	VendorName \"AOC\"
	ModelName  \"AOCModel\"
EndSection

Section \"Screen\"
    Identifier     \"NVIDIA\"
    Device         \"NVIDIA\"
    Monitor	   \"MonitorExternal\"
    DefaultDepth    24
EndSection


Section \"Device\"
    Identifier     \"NVIDIA\"
    Driver         \"nvidia\"
    VendorName     \"NVIDIA Corporation\"
    BusID          \"PCI:$NVIDIA_BUS_ID:0\"
EndSection

"

if [ $1 == "--nvidia" ];then
  echo "${COMMON_XORG_FILE_CONTENT}${NVIDIA_SERVER_LAYOUT}${NVIDIA_VIDEO_DEVICE_ENTRY}" | tee /etc/X11/xorg.conf
elif [ $1 == "--amd" ];then
    echo "${COMMON_XORG_FILE_CONTENT}${AMD_SERVER_LAYOUT}${AMD_VIDEO_DEVICE_ENTRY}" | tee /etc/X11/xorg.conf
elif [ $1 == "--multi-monitor" ];then
    echo "${COMMON_XORG_FILE_CONTENT}${AMD_SERVER_LAYOUT}${AMD_VIDEO_DEVICE_ENTRY}${NVIDIA_VIDEO_DEVICE_ENTRY}" | tee /etc/X11/xorg.conf
fi

echo "[+] DONE: Reconfigured Xorg. Relogin to apply effects"
