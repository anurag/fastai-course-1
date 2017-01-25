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




## Running on AWS
### GPU instance
```bash
# spin up a p2.xlarge instance
docker-machine create \
  --driver amazonec2 \
  --amazonec2-region='us-west-2' \
  --amazonec2-root-size=50 \
  --amazonec2-ami='ami-e03a8480' \
  --amazonec2-instance-type='p2.xlarge' \
  fastai-p2

# open Jupyter port 8888
aws ec2 authorize-security-group-ingress --group-name docker-machine --port 8888 --protocol tcp --cidr 0.0.0.0/0

# open an SSH shell on the new machine
docker-machine ssh fastai-p2

# (on the remote machine fastai-p2) run Jupyter interactively
nvidia-docker run -it -p 8888:8888 deeprig/fastai-course-1

# (on your local machine) get the IP of the new machine:
docker-machine ip fastai-p2
```
Open http://[NEW_MACHINE_IP]:8888 in your browser to view notebooks.

### CPU instance
```bash
# spin up a t2.xlarge instance
docker-machine create \
  --driver amazonec2 \
  --amazonec2-region='us-west-2' \
  --amazonec2-root-size=50 \
  --amazonec2-ami='ami-a073cdc0' \
  --amazonec2-instance-type='t2.xlarge' \
  fastai-t2

# open Jupyter port 8888
aws ec2 authorize-security-group-ingress --group-name docker-machine --port 8888 --protocol tcp --cidr 0.0.0.0/0

# open an SSH shell on the new machine
docker-machine ssh fastai-t2

# (on the remote machine fastai-t2) run Jupyter interactively
docker run -it -p 8888:8888 deeprig/fastai-course-1

# (on your local machine) get the IP of the new machine:
docker-machine ip fastai-t2
```
Open http://[NEW_MACHINE_IP]:8888 in your browser to view notebooks.
