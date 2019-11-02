FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER @mynameismaxz (github.com/mynameismaxz)

# install all-of-package
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/ffmpeg-4 -y && \
    apt-get update && \
    apt-get install -y build-essential \
    python-pip \
    python-dev \
    python-numpy \
    python3-dev \
    python3-setuptools \
    python3-numpy \
    python3-pip \
    make \
    cmake \
    libavcodec-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    ffmpeg \
    wget \
    git \
    libcurl4-gnutls-dev \
    zlib1g-dev \
    liblapack-dev \
    libatlas-base-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libswscale-dev \
    libdc1394-22-dev \
    libzip-dev \
    libboost* \
    zip \
    unrar \
    yasm \
    pkg-config \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libavformat-dev \
    libpq-dev \
	libxine2-dev \
	libglew-dev \
	libtiff5-dev \
	zlib1g-dev \
	libjpeg-dev \
	libpng12-dev \
	libjasper-dev \
	libavcodec-dev \
	libavformat-dev \
	libavutil-dev \
	libpostproc-dev \
	libswscale-dev \
	libeigen3-dev \
	libtbb-dev \
	libgtk2.0-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data

WORKDIR /data

# unlink old-python (python2) & make new symbolic-link for python3
RUN unlink /usr/bin/python \
    && unlink /usr/bin/pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && pip install --upgrade pip

# install essential python package
RUN pip install torchvision==0.4.0 \
    cython==0.29.11 \
    numpy==1.16.4 \
    scipy \
    pandas \
    matplotlib \
    scikit-learn \
    opencv-contrib-python-headless



# clone repository (mmaction)
RUN git clone --recursive https://github.com/open-mmlab/mmaction.git



# install mmcv
RUN git clone --recursive https://github.com/open-mmlab/mmcv.git \
    && cd mmcv \
    && pip install -e .

# setup mmaction
RUN cd mmaction \ 
    && chmod 777 compile.sh \
    && ./compile.sh \
    && python3 setup.py develop
