# Docker for [fast.ai](http://course.fast.ai) Course 1
A Jupyter environment for fast.ai's Deep Learning MOOC at http://course.fast.ai.

Runs a Jupyter notebook on port 8888 with the default password used in the course ('dl_course').

Uses CPUs by default and NVIDIA GPUs when run with [nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

## Usage
```bash
docker run -it -p 8888:8888 deeprig/fastai-course-1
```
