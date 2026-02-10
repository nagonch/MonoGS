# Base image: NVIDIA CUDA 11.6 development container
FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
        python3.8 \
        python3.8-dev \
        python3-pip \
        python3-setuptools \
        build-essential \
        git \
        wget \
        ffmpeg \
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
        libgl1-mesa-glx \
        && rm -rf /var/lib/apt/lists/*


# Upgrade pip
RUN python3.8 -m pip install --upgrade pip==22.3.1

# Install PyTorch with CUDA 11.6 support
RUN python3.8 -m pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu116

# Install other Python dependencies
RUN python3.8 -m pip install \
        tqdm \
        plyfile==0.8.1 \
        opencv-python==4.8.1.78 \
        munch \
        trimesh \
        evo==1.11.0 \
        open3d==0.17.0 \
        torchmetrics \
        imgviz \
        PyOpenGL \
        glfw \
        PyGLM \
        wandb \
        lpips \
        rich \
        ruff 
COPY . /workspace
WORKDIR /workspace

ENV CUDA_HOME=/usr/local/cuda
ENV PATH=$CUDA_HOME/bin:$PATH
ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
ENV TORCH_CUDA_ARCH_LIST="8.6"

RUN python3.8 -m pip install submodules/simple-knn --no-build-isolation
RUN python3.8 -m pip install submodules/diff-gaussian-rasterization --no-build-isolation

# Default command
RUN echo 'alias python="python3.8"' >> ~/.bashrc
