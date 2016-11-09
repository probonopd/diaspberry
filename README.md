# diaspberry
Host diaspora* conveniently on your Raspberry Pi

Master ![Build status](https://travis-ci.org/diaspberry/diaspberry.svg?branch=master)  
Develop ![Build status](https://travis-ci.org/diaspberry/diaspberry.svg?branch=develop)

## Build steps
1. Install [packages](http://www.yoctoproject.org/docs/2.1/yocto-project-qs/yocto-project-qs.html#packages) on the build host

2. Clone Poky
 
    ```
    $ git clone git@github.com:diaspberry/poky.git
    ```

3. Clone Raspberry Pi Meta Layer

    ```
    $ cd poky
    $ git clone git@github.com:diaspberry/meta-raspberrypi.git
    ```

4. Clone Diaspberry Meta Layer

   ```
   $ git clone git@github.com:diaspberry/meta-diaspberry.git
   ```

5. Checkout Yocto release branch

    ```
    $ git checkout -b krogoth origin/krogoth
    ```

6. Initialize the Build Environment

    ```
    $ source oe-init-build-env build
    ```

7. Adjust the build cofiguration

    ```
    $ vim conf/local.conf

    --- 8< ---
    BB_NUMBER_THREADS = "9"
    PARALLEL_MAKE = "-j 9"
    MACHINE ?= "raspberrypi"
    GPU_MEM = "16"
    --- >8 ---
    ```

8. Adjust the Bit Bake Layers configuration

    ```
    $ vim conf/bblayers.conf
    BBLAYERS ?= " \
        /workspace/diaspberry/poky/meta \
        /workspace/diaspberry/poky/meta-yocto \
        /workspace/diaspberry/poky/meta-yocto-bsp \
        /workspace/diaspberry/poky/meta-raspberrypi \
        /workspace/diaspberry/poky/meta-diaspberry \
        "
    ``` 

9. Build the Basic image, this takes some time (~1 hour on fast machines)

    ```
    $ bitbake rpi-basic-image
    ```

10. Copy the image on a sd card. ATTENTION: Choose the right device for the SD Card carefully!

    ```
    $ sudo dd if=tmp/deploy/images/rpi-basic-image-raspberrypi.rpi-sdimg of=</dev/sdcard> bs=1M
    ```
Done. You can now put the SD Card into your Pi and boot Diaspberry.

## Configuration

TODO: Write some instructions regarding the Setup Wizard.
