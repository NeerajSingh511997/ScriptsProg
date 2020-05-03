#| #!/bin/bash


#| Author: Neeraj Singh Junior
#| Objective: Exploring xdotools;
#| Usage: FILENAME [-a|-b] [PARAMETERS]
#|        -c  OPTIONS your_message.


# using loop

# for x in `seq 1 2`
# do 
#     # alt swipe
#     xdotool key 'alt+0xff09';
#     sleep 2s
#     # home
#     xdotool key 'super+d'
#     sleep 2s
#     # multi window
#     xdotool key 'super+s'
#     sleep 1s
#     # Escape key;
#     xdotool key Escape
#     sleep 2s
#     xdotool key 'Alt_L+23'
#     #opening google chrome
# done

# end loop

# Google chrome

# `google-chrome --incognito &`
# sleep 1s;
# xdotool key 'ctrl+j'
# sleep 1s;   
# xdotool mousemove 100 50 click 2

# end google-chrome


# xdotool key 'Super+e'


# Move Mouse 

# xdotool mousemove 100 0 click 1
# sleep 2s
# xdotool mousemove 100 100 click 6

# end > Mouse

## Holding mouse movement

xdotool mousemove 250 80
sleep 2s
xdotool keydown Pointer_Button1
sleep 2s
xdotool mousemove_relative 0 100
sleep 2s
xdotool keyup Pointer_Button1
sleep 2s

## end > holding mouse movement