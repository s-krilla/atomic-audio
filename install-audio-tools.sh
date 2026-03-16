#!/bin/bash

declare -A Tools=(
  [org.pipewire.Helvum]="Helvum - Patchbay for PipeWire"
  [org.rncbc.qpwgraph]="qpwgraph - A PipeWire Graph Qt GUI Interface"
  [me.timschneeberger.jdsp4linux]="JamesDSP - Open-source audio effect processor for Pipewire"
  [com.github.wwmm.easyeffects]="Easy Effects - Simple audio effects (broken - not recommended)"
)

declare -A DAWs=(
  [io.lmms.LMMS]="LMMS - A music production application"
  [org.ardour.Ardour]="Ardour - Digital Audio Workstation"
  [org.rncbc.qtractor]="Qtractor - An Audio/MIDI multi-track sequencer"
  [fm.reaper.Reaper]="Reaper - Digital Audio Workstation"
  [com.bitwig.BitwigStudio]="Bitwig Studio - Modern music production and performance"
  [org.audacityteam.Audacity]="Audacity - Audacity is the world's most popular audio editing and recording app"
)

declare -A InstalledApps
for pak in ${!Tools[@]}; do
  if flatpak info $pak >/dev/null 2>&1; then
    InstalledApps[$pak]="${Tools[$pak]}"
  fi
done
for pak in ${!DAWs[@]}; do
  if flatpak info $pak >/dev/null 2>&1; then
    InstalledApps[$pak]="${DAWs[$pak]}"
  fi
done

# echo "${InstalledApps[@]}"
# echo "${!InstalledApps[@]}"

IFS=','
ChosenTools=$(gum choose --no-limit --header "Choose Audio Tools to Install or Uninstall" --selected="${InstalledApps[*]}" "${Tools[@]}")
ChosenDAWs=$(gum choose --no-limit --header "Choose Digital Audio Workstations to Install or Uninstall" --selected="${InstalledApps[*]}" "${DAWs[@]}")  
IFS=$'\n'
ChosenApps=($ChosenTools)
ChosenApps+=($ChosenDAWs)

# echo "Chosen: " "${ChosenApps[@]}"

declare -A DesiredApps
for value in "${ChosenApps[@]}"; do
  for key in "${!Tools[@]}"; do
    if [[ "${Tools[$key]}" == "$value" ]]; then
      DesiredApps[$key]="$value"
      break
    fi
  done
  for key in "${!DAWs[@]}"; do
    if [[ "${DAWs[$key]}" == "$value" ]]; then
      DesiredApps[$key]="$value"
      break
    fi
  done
done

# echo "${DesiredApps[@]}"
# echo "${!DesiredApps[@]}"

ToInstall=()
for app in "${!DesiredApps[@]}"; do
  if [[ ! " ${!InstalledApps[@]} " =~ " ${app} " ]]; then
    ToInstall+=("$app")
  fi
done
if [ ${#ToInstall[@]} -ne 0 ]; then
  flatpak install -y flathub "${ToInstall[@]}"
fi

ToRemove=()
for app in "${!InstalledApps[@]}"; do
    if [[ ! " ${!DesiredApps[@]} " =~ " ${app} " ]]; then
        ToRemove+=("$app")
    fi
done
if [ ${#ToRemove[@]} -ne 0 ]; then
  for app in "${ToRemove[@]}"; do
    flatpak kill "$app" &> /dev/null
  done
  flatpak uninstall -y "${ToRemove[@]}"
fi

if [ ${#ToRemove[@]} -eq 0 ] && [ ${#ToInstall[@]} -eq 0 ]; then
  echo "Nothing to do."
fi
