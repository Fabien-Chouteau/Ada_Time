# Ada_Time

Ada_Time is a lightweight binding for the [Pebble
Time](https://www.pebble.com/) smartwatch.


This repository contains two examples that you can install to your watch:
 - [Patris](http://apps.getpebble.com/en_US/application/559af16358bc81d930000067) : It's a game inspired by the famous classic falling blocks.
   [Download it here.](http://apps.getpebble.com/en_US/application/559af16358bc81d930000067)
 - Patris watchface (soon...) : Falling blocks telling you what time is it.

## Install

For this project you will need GNAT for ARM bare-board. You can find the GPL
version at [libre.adacore.com](http://libre.adacore.com), in the download
section. See the documentation for installation.

You also need a Pebble SDK (tested on version 3.2)
[developer.getpebble.com/sdk/](http://developer.getpebble.com/sdk/).

## Build

For each app you have to build the Ada code first:

```shell
$ cd projects/Patris/ada
$ gprbuild -XBuild=Release
```

then go back to the Pebble project directory, build and test:

```shell
$ cd ..
$ pebble build && pebble install --emulator basalt
```
