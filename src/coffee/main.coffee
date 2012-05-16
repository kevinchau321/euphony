# function to convert a note to the corresponding color(synesthesia)
noteToColor = do ->
  map = MusicTheory.Synesthesia.map('August Aeppli (1940)')
  (note) ->
    parseInt(map[note - MIDI.pianoKeyOffset].hex, 16)

$(document).ready ->
  # global loader to show progress of MIDI.js
  window.loader = new LoaderWidget()

  # create scene
  scene = new Scene('#container')

  # the keyboard design is used by both the keyboard and rain
  design = new PianoKeyboardDesign()

  # create keyboard
  keyboard = new PianoKeyboard(design)
  scene.add(keyboard.model)

  rain = null

  scene.animate ->
    keyboard.update()

  # initialize MIDI
  MIDI.loadPlugin ->
    loader.stop()
    player = MIDI.Player

    # synchronize piano keyboard with note events
    NOTE_OFF = 128
    NOTE_ON  = 144
    player.addListener (data) ->
      {note, message} = data
      if message is NOTE_ON
        keyboard.press(note)
      else if message is NOTE_OFF
        keyboard.release(note)

    # load tracks
    trackNames = Object.keys(MIDIFiles)
    player.loadFile MIDIFiles[trackNames[0]], (midifile) ->

      # create rain
      if rain
        scene.remove(rain.model)
      rain = new NoteRain
        midiData: MIDI.Player.data
        pianoDesign: design
        noteToColor: noteToColor
      scene.add(rain.model)

      # start player
      player.start()
      player.setAnimation
        delay: 30
        callback: (data) -> rain.update(data.now * 1000)
