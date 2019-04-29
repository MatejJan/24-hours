#!/usr/bin/env bash

cat \
utilities.moon \
\
source/resource.moon \
source/resources.moon \
\
source/event.moon \
source/events.moon \
\
source/startturn.moon \
source/allocation.moon \
source/outcomes.moon \
source/story.moon \
source/endturn.moon \
\
source/initialize.moon \
source/main.moon \
> source.moon

moonc source.moon

cat header source.lua utilities.lua memory > ludumdare44.p8

osascript -e 'tell application "PICO-8" to activate'
osascript -e 'tell application "System Events" to keystroke "r" using {control down}'
