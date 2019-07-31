# meta-tensorflow

## Introduction
TensorFlow is an open source software library for high performance numerical
computation primarily used in machine learning. Its flexible architecture
allows easy deployment of computation across a variety of types of platforms
(CPUs, GPUs, TPUs), and a range of systems from single desktops to clusters
of servers to mobile and edge devices.
(https://www.tensorflow.org/)

The build system of TensorFlow is Bazel (https://bazel.build/).

This layer integrates TensorFlow to OE/Yocto platform
- Integrate Google's bazel to Yocto
- Add Yocto toolchain for bazel to support cross compiling.
- Replace python package system(pip/wheel) with Yocto package system(rpm/deb/ipk).

## Dependencies
URI: git://github.com/openembedded/openembedded-core.git
branch: master
revision: HEAD

URI: git://github.com/openembedded/bitbake.git
branch: master
revision: HEAD

URI: git://github.com/openembedded/meta-openembedded.git
layers: meta-python, meta-oe
branch: master
revision: HEAD

# License

All metadata is MIT licensed unless otherwise stated. Source code included
in tree for individual recipes is under the LICENSE stated in each recipe
(.bb file) unless otherwise stated.

# Attribution
TensorFlow, the TensorFlow logo and any related marks are trademarks of Google Inc.
