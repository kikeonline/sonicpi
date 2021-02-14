use_debug true
use_random_seed 667
load_sample :ambi_lunar_land
use_bpm 67
sleep 1

octave = 4  #Korg volca riff octaves
korg_bass = "umc404hd_192k"

#Riser noise
live_loop :bar, auto_cue: false do
  if rand < 0.25
    sample :ambi_lunar_land
    puts :comet_landing
  end
  sleep 8
end

#Beat & Chord
live_loop :baz, auto_cue: false do
  tick
  sleep 0.25
  cue :beat, count: look
  sample :bd_haus, amp: factor?(look, 8) ? 3 : 2
  sleep 0.25
  use_synth :fm
  play chord(:e4, :minor), release: 1, amp: 1 if factor?(look, 4)
  synth :noise, release: 0.051, amp: 1
end

#Snap
live_loop :virveli do
  sleep 1
  with_fx :reverb, mix: 0.5 do
    sample :perc_snap, amp: 1.5
  end
  sleep 1
end

# External Korg VolcaBASS
live_loop :acid_trigger do
  cue :foo
  use_real_time
  midi (scale :e2 , :minor_pentatonic, num_octaves: octave).choose, sustain: 0.1, port: korg_bass
  sleep 0.125
end

# Sound In from NTS-1 stereo out
live_audio :korg, stereo: true, input: 3


