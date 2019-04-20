# regal
a simple regular alarm for terminal

a very simple terminal regular alarm in seconds/minutes/hours that will play a song and display a message every x amount of time.

# installation
```sh
yay -a regal
or
yaourt -a regal
```

# usage
<pre>
<b>regal</b> [EVERY_X_TIME] [TIME_MODE] [HOW_MANY_TIME] [AUDIO_PATH]
<b>options:</b>
<!-- -->         <b>EVERY_X_TIME</b>        must be an integer such as 42
<!-- -->         <b>TIME_MODE</b>        "h" for hours, "m" for minutes or "s" for seconds
<!-- -->         <b>HOW_MANY_TIME</b>        number of repetition, must be an integer such as 42 or "inf" for ever
<!-- -->         <b>AUDIO_PATH</b>        to play another audio than the duck one by default
</pre>


# examples
every 20 seconds for ever:<br/>
```sh
regal 20 s
```
every 50 minutes for ever:<br/>
```sh
regal 50 m inf ~/audio/duck_song.mp3
```
every 4 hours for 4 hours:<br/>
```sh
regal 1 h 4 ~/audio/duck_song.mp3
```
