#!/bin/bash

# Disable
if [ -e "${HOME}/.config/realtime-audio" ] ; then
  if gum confirm "Would you like to disable real-time audio configurations?" ; then
    # Remove User from Audio Group
    sudo sed -i "/$(getent group audio)/d" /etc/group
    # Remove audio priority
    sudo sed -i '/@audio/d' /etc/security/limits.conf
    # Remove cpu latency rule
    sudo rm -f /etc/udev/rules.d/99-cpu-dma-latency.rules
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    rm -f "${HOME}/.config/realtime-audio"
    echo "Successfully disabled"
    if gum confirm --default=false "Reboot?" ; then
      systemctl reboot
    fi
    exit 0
  fi
fi

# Enable
if gum confirm "Would you like to enable real-time audio configurations?" ; then
  touch "${HOME}/.config/realtime-audio"
  # Add User to Audio Group
  printf '%s' "$(getent group audio)" "$USER" | sudo tee -a /etc/group
  # Add audio priority
  printf '%s\n' "@audio - rtprio 90" \
                "@audio - memlock unlimited" | sudo tee -a /etc/security/limits.conf
  # Add cpu latency rule
  printf '%s' 'DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"' | sudo tee /etc/udev/rules.d/99-cpu-dma-latency.rules
  sudo udevadm control --reload-rules
  sudo udevadm trigger
  echo "Successfully enabled"
  if gum confirm --default=false "Reboot?" ; then
    systemctl reboot
  fi
  exit 0
fi
