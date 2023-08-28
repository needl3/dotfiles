if [ "$(id -u)" -ne 0 ]; then
    echo 'Run as a root' >&2
    exit 1
fi

RADEON_BUS_ID=$(lspci | grep Radeon | awk '{print $1}' | cut -c1-5)
NVIDIA_BUS_ID=$(lspci | grep GeForce | awk '{print $1}' | cut -c1-5)

COMMON_XORG_FILE_CONTENT='
Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

Section "Files"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    DefaultDepth    24
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
'

AMD_VIDEO_DEVICE_ENTRY="
Section \"Device\"
    Identifier     \"Device0\"
    Driver         \"modesetting\"
    VendorName     \"Advanced Micro Devices\"
    BusID          \"PCI:$RADEON_BUS_ID:0\"
EndSection
"

NVIDIA_VIDEO_DEVICE_ENTRY="
Section \"Device\"
    Identifier     \"Device0\"
    Driver         \"nvidia\"
    VendorName     \"NVIDIA Corporation\"
    BusID          \"PCI:$NVIDIA_BUS_ID:0\"
EndSection
"

if [ $1 == "-n" ];then
    echo "${COMMON_XORG_FILE_CONTENT}${NVIDIA_VIDEO_DEVICE_ENTRY}" | tee /etc/X11/xorg.conf
else
    echo "${COMMON_XORG_FILE_CONTENT}${AMD_VIDEO_DEVICE_ENTRY}" | tee /etc/X11/xorg.conf
fi

read -p "[+] Reconfigured Xorg. Relogin to apply effects?(y/N)" relogin
if [[ $relogin == "y" ]];then
    pkill -TERM dwm
fi
