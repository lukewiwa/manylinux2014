# manylinux2014 Multi-Arch Docker Build

[`manylinx`](https://github.com/pypa/manylinux) distributes its docker images with different architectures under different tags. This repo simply pulls these images and uses the [docker manifest](https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/) command to aggregate these images into a multi arch manifest.

This somewhat crudely solves [this issue](https://github.com/pypa/manylinux/issues/1306) about the difficulties of providing multi architecture builds.
