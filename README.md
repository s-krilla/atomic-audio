# realtime-audio

## Getting Started

Helpful scripts to configure audio in Linux.

- Easily toggle real-time audio configurations on and off
- Install or remove audio tools and DAWs

### Compatibility 

Intended for use with Universal Blue-based distros: 

- Bluefin
- Aurora
- Bazzite 

Other distributions should work if prerequisites are met. 

### Prerequisites

- pipewire
- `audio` group
- gum
- flatpak w/ flathub repo

## Scripts

`git clone https://github.com/s-krilla/realtime-audio.git` or  download

Navigate to directory

### Usage

#### toggle-realtime-audio

1. Adds user to the `audio` group
2. Gives `audio` real-time priority
3. Allows DAWs to adjust CPU latency


Make executable:

`chmod +x toggle-realtime-audio.sh`

Run:

`./toggle-realtime-audio.sh`

#### install-audio-tools

1. Choose to install/remove curated Audio Tools
2. Choose to install/remove Digital Audio Workstations

Make executable:

`chmod +x install-audio-tools.sh`

Run:

`./install-audio-tools.sh`