# Docker for [fast.ai](http://course.fast.ai) Course 1
A Jupyter environment for fast.ai's Deep Learning MOOC at http://course.fast.ai.

Runs a Jupyter notebook on port 8888 with the default password used in the course ('dl_course').

Uses CPUs by default and NVIDIA GPUs when run with [nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

The container comes with:
* All notebooks from https://github.com/fastai/courses/tree/master/deeplearning1/nbs
* Python 2.7 (the default Python version used in the course)
* Conda
* Theano
* Keras
* PIL
* Jupyter
* bcolz
* kaggle-cli
* ...all other libraries needed for the course.

## Usage
```bash
docker run -it -p 8888:8888 deeprig/fastai-course-1
```
