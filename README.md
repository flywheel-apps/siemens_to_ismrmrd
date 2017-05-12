[![Docker Pulls](https://img.shields.io/docker/pulls/flywheel/siemens_to_ismrmrd.svg)](https://hub.docker.com/r/flywheel/siemens_to_ismrmrd/)
[![Docker Stars](https://img.shields.io/docker/stars/flywheel/siemens_to_ismrmrd.svg)](https://hub.docker.com/r/flywheel/siemens_to_ismrmrd/)

# siemens_to_ismrmrd
Siemens to ISMRMRD converter

Build context for a [Flywheel Gear](https://github.com/flywheel-io/gears/tree/master/spec) which runs the `siemens_to_ismrmrd` tool (v1.0.1).
For more information on the ISMRMRD format see [ISMRMRD's documentation](http://ismrmrd.github.io/)

* You can change ```build.sh``` to edit the repository name for the image (default=`flywheel/siemens_to_ismrmrd`).
* The resulting image is ~1GB

### Build the Image
To build the image:
```
git clone https://github.com/flywheel-apps/siemens_to_ismrmrd.git
./build.sh
```

### Example Local Usage
To run the `siemens_to_ismrmrd` command in this image on your local instance, do the following:
```
docker run --rm -ti \
  -v </path/to/input/data>:/flywheel/v0/input/dat \
  -v </path/for/output/data>:/flywheel/v0/output \
  flywheel/siemens_to_ismrmrd
```

Usage notes:
  * You are mounting the directory (using the ```-v``` flag) which contains the input data in the container at ```/flywheel/v0/input/``` and mounting the directory where you want your output data within the container at ```/flywheel/v0/output```.
  * The input directory should contain only the file you wish to convert (a .dat file)
  * If an alternate parameter map (.xml file) for conversion is desired, an optional directory can be mounted with the additional line ```-v </path/to/xml/data>:/flywheel/v0/input/user_map```
  * If an alternate stylesheet (.xsl file) for conversion is desired, an optional directory can be mounted with the additional line ```-v </path/to/xsl/data>:/flywheel/v0/input/user_stylesheet```
  * No input arguments are required for the container to be executed
