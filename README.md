# Makefile
* make conda-lock : update conda-lock file with environment.yml file and environment.yml from all base layer chosen at the creation of this VRE (all environment yaml are available in .base/layer folder)  
A modification in environment.yml is taken into account only if conda-lock file is updated.

* make apt : merge apt.txt and all apt.txt file from base layer chosen at the creation of this VRE

* make docker : build the VRE using docker 

* make update : update base layer file
make conda-lock and make apt will be needed before make docker or CI launch.

**Note :** It is necessary after `git clone` to use the makefile command `make update`. Otherwise you won't have the .base_layer repository !

# Module

Other modules may be used by adding them within the resources directory. (see documentation)


# environement.yml

packages can be added to the VRE conda environment by adding them to the environment.yml file and run ``make conda-lock`` to update conda lock file before pushing modification into the CI.
