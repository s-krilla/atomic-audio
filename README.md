# realtime-audio

## Getting Started

Helpful scripts to configure audio in Linux.

- Easily toggle real-time audio configurations on and off per [linuxaudio.org Wiki](https://wiki.linuxaudio.org/wiki/system_configurationhttps://example.com) recommendations
- Install or remove audio tools and DAWs

### Compatibility 

Intended for use with [Universal Blue](https://universal-blue.org/)-based systems: 

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

Download or `git clone https://github.com/s-krilla/realtime-audio.git`

Navigate to directory...

### Usage

#### toggle-realtime-audio

1. Adds user to the `audio` group - https://wiki.linuxaudio.org/wiki/system_configuration#audio_group
2. Gives `audio` real-time priority - https://wiki.linuxaudio.org/wiki/system_configuration#limitsconfaudioconf
3. Allows DAWs to adjust CPU latency - https://wiki.linuxaudio.org/wiki/system_configuration#quality_of_service_interface


Make executable:

`chmod +x toggle-realtime-audio.sh`

Run:

`./toggle-realtime-audio.sh`

#### install-audio-tools

See Flatpak list here: https://github.com/s-krilla/realtime-audio/blob/main/install-audio-tools.sh

1. Choose to install/remove curated Audio Tools
2. Choose to install/remove Digital Audio Workstations

Make executable:

`chmod +x install-audio-tools.sh`

Run:

`./install-audio-tools.sh`