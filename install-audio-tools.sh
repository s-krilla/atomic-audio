#!/bin/bash

# declare -A Flatpaks=(
#   [me.timschneeberger.jdsp4linux]="Washington D.C."
#   [org.rncbc.qpwgraph]="Tokyo"
#   [org.pipewire.Helvum]="Paris"
#   [Germany]="Berlin"
# )


Flatpaks=(
  "me.timschneeberger.jdsp4linux"
  "org.rncbc.qpwgraph"
  "org.pipewire.Helvum"
)

InstalledApps=()
for pak in ${Flatpaks[@]}; do
  if flatpak info $pak >/dev/null 2>&1; then
    InstalledApps+=("$pak")
  fi
done

# echo "${InstalledApps[@]}"

IFS=','
DesiredApps=$(gum choose --no-limit --output-delimiter=" " --header "Choose Flatpaks to Install or Uninstall" --selected="${InstalledApps[*]}" "${Flatpaks[@]}") 
IFS=' '
DesiredApps=($DesiredApps)

# echo "${DesiredApps[0]}"

ToInstall=()
for app in "${DesiredApps[@]}"; do
  if [[ ! " ${InstalledApps[@]} " =~ " ${app} " ]]; then
    ToInstall+=("$app")
  fi
done
# echo "To Install: " "${ToInstall[@]}"
if [ ${#ToInstall[@]} -ne 0 ]; then
  flatpak install -y flathub "${ToInstall[@]}"
fi

# Remove apps that are installed but not desired
ToRemove=()
for app in "${InstalledApps[@]}"; do
    if [[ ! " ${DesiredApps[@]} " =~ " ${app} " ]]; then
        ToRemove+=("$app")
    fi
done
# echo "To Remove: " "${ToRemove[@]}"
if [ ${#ToRemove[@]} -ne 0 ]; then
  for app in "${ToRemove[@]}"; do
    flatpak kill "$app" &> /dev/null
  done
  flatpak uninstall -y "${ToRemove[@]}"
fi

if [ ${#ToRemove[@]} -eq 0 ] && [ ${#ToInstall[@]} -eq 0 ]; then
  echo "Nothing to do."
fi


# if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
#     echo "Running GNOME"
#     pip3 install --upgrade gnome-extensions-cli

# fi