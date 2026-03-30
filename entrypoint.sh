#!/bin/sh
FILENAME=dataset.zip
curl -L "$1" > $FILENAME
unzip $FILENAME

uvx --from ultralytics yolo train data=data.yaml model=yolo26n-seg.pt epochs=10 lr0=0.01
uvx --from ultralytics yolo export model=./runs/segment/train/weights/best.pt format=onnx opset=14

uvx copyparty


