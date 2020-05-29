# Scripts
This folder contains all sorts of different scripts. Put these files
in your path, to make other scripts work properly. 99% of the scripts are
POSIX-Compliantand and checked with
[shellcheck](https://github.com/koalaman/shellcheck).

Each script contains a header with a short discription, depencies,
installation or usage notes. Check it out if you want to know more about it.

# Installation
Some scripts depend on other scripts/programs so see table below
or the header in the corresponing file to satisfy depencies.

|script        |discription|depencies|
|--------------|-----------|---------|
|active-gpu.sh |echos currently used gpu|glx-info|
|autolock.sh   |autolock + energy saving|xidlehook, xset, systemd suspend|
|autorotate.sh |rotate screen based on device orientation|monitor-sensor, xrander, xinput, (polybar)|
|backlight.sh  |set monitor brightness|light, bc, dunst, Papirus-Dark|
|bat-warning.sh|notification on low battery|bc, dunst, Papirus-Dark|

# Icons
Many of these script uses notfications with icons. If you don't like my icon set
or just want to change them feel free to do so. The resources below can give
you some ideas for icons to try.
- [Gnome naming spec](https://developer.gnome.org/icon-naming-spec/)
- [Freedesktop naming spec](https://specifications.freedesktop.org/icon-naming-spec/icon-naming-spec-latest.html)

