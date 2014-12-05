Go QML Ubuntu SDK template for armhf cross-compilation
======================================================

This is a template for a Go QML Ubuntu SDK project with custom build scripts for armhf cross-compilation.
It includes scripts to set up and configure a click chroot to allow armhf cross-compilation for Go QML projects.

Setting up the build environment:
---------------------------------

First of all, you need to install the Ubuntu SDK as described in the official documentation: http://developer.ubuntu.com/start/ubuntu-sdk/installing-the-sdk/

In order to be able to compile the template on your PC, you also need to install a few more packages by running the following command:

```
sudo apt-get install golang g++ qtdeclarative5-dev qtbase5-private-dev qtdeclarative5-private-dev libqt5opengl5-dev qtdeclarative5-qtquick2-plugin
```

Now it comes to setting up the chroot. Clone the git repository and run the chroot setup scripts using the following commands:

```
git clone https://github.com/nikwen/ubuntu-go-qml-template.git
cd ubuntu-go-qml-template
chroot-scripts/setup-chroot.sh
```

Note that it is important to call the `setup-chroot.sh` script from the top-level project directory.

These commands will create a new click chroot or update an already existing one with the required build dependencies. Afterwards, it will install version 1.3.3 of Go inside the project directory, as it is required for cross-compiling the Go QML package. (Don't worry. The system will not use this one by default. Other projects will still use the `golang` package installed via `apt-get install golang`.)

Running the project on your PC:
-------------------------------

Running the project on your PC is quite simple. You can either run it from Qt Creator or use the `run.sh` script, which invokes `build.sh` for building.

Installing the project on your Ubuntu Phone:
--------------------------------------------

If you want to install the project on your Ubuntu Phone, you just need to run the `install-on-device.sh` script. It will build the project using the `build-in-chroot.sh` script, push the generated click package to your device using adb and install it using `pkcon install-local`.

About using this template:
--------------------------

This software is released under the [ISC license](http://choosealicense.com/licenses/isc/), a simple and permissive one which allows you to reuse this code in free and paid software projects alike, without the need to share your source code.
I would be very pleased if you add a link to this project to your "About" page and/or let me know that someone is actually using it, but it is, of course, no requirement to do so.

Big thanks to:
--------------

 * [Dimitri John Ledkov](https://github.com/xnox "Github profile") for publishing [a great blog post](http://blog.surgut.co.uk/2014/06/cross-compile-go-code-including-cgo.html "cross-compile go code, including cgo") on Go cross-compilation using Ubuntu click chroots. Thank you very, very much for getting me started!
