FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

MAINTAINER Anurag Goel <deeprig@anur.ag>

ARG PYTHON_VERSION=2.7
ARG CONDA_PYTHON_VERSION=2
ARG CONDA_VERSION=4.2.12
ARG CONDA_DIR=/opt/conda
ARG TINI_VERSION=v0.13.2
ARG USERNAME=docker
ARG USERID=1000

RUN apt-get update && \
  apt-get install -y --no-install-recommends git wget ffmpeg unzip sudo && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Conda
ENV PATH $CONDA_DIR/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && \
  wget --quiet https://repo.continuum.io/miniconda/Miniconda$CONDA_PYTHON_VERSION-$CONDA_VERSION-Linux-x86_64.sh -O /tmp/miniconda.sh && \
  echo 'export PATH=$CONDA_DIR/bin:$PATH' > /etc/profile.d/conda.sh && \
  /bin/bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
  rm -rf /tmp/* && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Tini makes notebook kernels work
ADD https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini /tini
RUN chmod +x /tini

# user's home dir should be mapped from EFS
RUN useradd --create-home -s /bin/bash --no-user-group -u $USERID $USERNAME && \
  chown $USERNAME $CONDA_DIR -R && \
  adduser $USERNAME sudo && \
  echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER $USERNAME

WORKDIR /home/$USERNAME

COPY .theanorc .
COPY keras.json .keras/
COPY jupyter_notebook_config.py .jupyter/

RUN conda install -y --quiet python=$PYTHON_VERSION && \
  conda install -y --quiet notebook h5py Pillow ipywidgets scikit-learn \
  matplotlib pandas bcolz sympy scikit-image mkl-service && \
  pip install --upgrade pip && \
  pip install tensorflow-gpu kaggle-cli && \
  pip install git+git://github.com/fchollet/keras.git@1.1.2 && \
  conda clean -tipsy

ENV CUDA_HOME=/usr/local/cuda
ENV CUDA_ROOT=$CUDA_HOME
ENV PATH=$PATH:$CUDA_ROOT/bin:$HOME/bin
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_ROOT/lib64

# Jupyter
EXPOSE 8888

# Clone fast.ai source
RUN git clone -q https://github.com/fastai/courses.git fastai-courses
WORKDIR /home/$USERNAME/fastai-courses/deeplearning1/nbs

ENTRYPOINT ["/tini", "--"]
CMD jupyter notebook --ip=0.0.0.0 --port=8888
