#!/bin/bash
# Wrapper script for Helm to avoid audio library issues in WSL
# Sets environment variables to prevent ALSA errors

# Disable ALSA audio driver
export SDL_AUDIODRIVER=dummy

# Disable PulseAudio
export PULSE_SERVER=dummy

# Run the actual helm command with all arguments
helm "$@"
