# docker-nuke

![](http://i.giphy.com/3PXARhAjAdeV2.gif)

Nukes containers / images / volumes.   You really shouldn't trust this.
I'm a good guy, but you should really read the source :)


## Usage

The easiest way to run it, which will always use the latest production-ready version from the master branch:

```
curl -sL http://bit.ly/NukeDockerData | bash
```

## Example

```
➜  ~ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
42baabece39d        busybox             "/bin/sh"           14 seconds ago      Up 13 seconds                                   cranky_austin
0a8f6163b75a        busybox             "/bin/sh"           54 seconds ago      Exited (0) 51 seconds ago                       focused_euler
b8bb94ab91b3        busybox             "/bin/sh"           6 minutes ago       Exited (0) 6 minutes ago                        fervent_bell
➜  ~ docker volume ls
DRIVER              VOLUME NAME
local               test_volume
➜  ~ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
busybox             latest              47bcc53f74dc        5 days ago          1.113 MB
➜  ~ curl -sL http://bit.ly/NukeDockerData | bash


    Looks like you may be running this via curl...
    Feel free to audit this script at https://github.com/jasonvasquez/docker-nuke

    About to nuke your docker world...
    All containers, images and volumes will be deleted permanently.

    Current Inventory:
        Running containers to be killed: 1
        Total containers to be deleted: 3

        Total images to be deleted: 1

        Total volumes to be deleted: 1

    You have 5 seconds to ^c-nope your way out of this.

5...
4...
3...
2...
1...
boom.

Killing running containers...
42baabece39d
Deleting containers...
42baabece39d
0a8f6163b75a
b8bb94ab91b3
Deleting images...
Untagged: busybox:latest
Deleted: sha256:47bcc53f74dc94b1920f0b34f6036096526296767650f223433fe65c35f149eb
Deleted: sha256:f6075681a244e9df4ab126bce921292673c9f37f71b20f6be1dd3bb99b4fdd72
Deleted: sha256:1834950e52ce4d5a88a1bbd131c537f4d0e56d10ff0dd69e66be3b7dfa9df7e6
Deleting volumes...
test_volume

done!
➜  ~
```
