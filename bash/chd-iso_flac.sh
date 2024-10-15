#!/bin/bash
 
# Check if bchunk, ffmpeg, and chdman are installed
if ! command -v bchunk &> /dev/null || ! command -v ffmpeg &> /dev/null || ! command -v chdman &> /dev/null; then
    echo "bchunk is required but not installed."
    exit 1
else ! command -v ffmpeg &> /dev/null; then 
    echo "ffmpeg is required but not installed"
    exit 1
else ! command -v chdman &> /dev/null; then
    echo "chdman (mame-tools) is required but not installed."
fi
 
# Function to extract .bin/.cue from .chd
extract_chd() {
    local chd_file="$1"
    local base_name="${chd_file%.chd}"
 
    echo "Extracting $chd_file to .bin and .cue..."
    chdman extractcd -i "$chd_file" -o "$base_name.cue" -ob "$base_name.bin"
}
 
# Function to convert .bin/.cue to .iso and .wav
convert_bin_cue() {
    local bin_file="$1"
    local cue_file="${bin_file%.bin}.cue"
    local base_name="${bin_file%.bin}"
 
    if [[ -f "$cue_file" ]]; then
        echo "Converting $bin_file and $cue_file to .iso and .wav..."
        bchunk -w "$bin_file" "$cue_file" "$base_name"
        rm "$bin_file" "$cue_file"
    else
        echo "Cue file for $bin_file not found."
    fi
}
 
# Function to convert .wav to .flac and delete .wav files
convert_wav_to_flac() {
    local wav_file="$1"
    local flac_file="${wav_file%.wav}.flac"
 
    echo "Converting $wav_file to $flac_file..."
    ffmpeg -i "$wav_file" "$flac_file" && rm "$wav_file"
}
 
# Main script
for chd_file in *.chd; do
    extract_chd "$chd_file"
done
 
for bin_file in *.bin; do
    convert_bin_cue "$bin_file"
done
 
for wav_file in *.wav; do
    convert_wav_to_flac "$wav_file"
done
 
printf "\nConversion Complete\n" |GREP_COLORS='mt=04;32' grep -E --color 'Conversion Complete|'
