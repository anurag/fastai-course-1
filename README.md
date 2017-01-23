# Docker for [fast.ai](http://course.fast.ai) Course 1
A Jupyter environment for fast.ai's Deep Learning MOOC at http://course.fast.ai.

Runs a Jupyter notebook on port 8888. Uses CPUs by default and NVIDIA GPUs when run with [nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

Expects a home directory to be mounted from the host at runtime (see usage)

## Usage
```bash
docker run -it \
    -p 8888:8888 \
    -v $HOME:/home/deeprig \
    --env HOME=/home/deeprig \
    -w=/home/deeprig \
    --name deeprig-fastai \
    deeprig/fastai-course-1 \
    jupyter notebook --ip=0.0.0.0 --port=8888
```
