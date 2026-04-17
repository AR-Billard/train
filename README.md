```sh
docker build -t cuebit . && docker run -it --rm --gpus=all --ipc=host cuebit <epoch> <url1> <basemodel1> [<url2> <basemodel2> ...]
``
