docker rm -f monogs
DIR=$(pwd)/
xhost +local:1000 && docker run --name monogs --gpus all -it -v /home:/home -v /home/ngoncharov/.cache/huggingface:/home/ngoncharov/.cache/huggingface monogs:latest bash -c "cd $DIR && bash" -e DISPLAY="$DISPLAY" \
-v "$HOME/.Xauthority:/root/.Xauthority:rw" \
    --network=host \
    --ipc=host