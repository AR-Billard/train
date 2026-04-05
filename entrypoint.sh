#!/bin/sh

FILENAME=dataset.zip
curl -L "$1" > $FILENAME
mkdir -p /workspace/datasets
unzip -o $FILENAME -d /workspace/datasets
rm $FILENAME

yolo detect train \
    model=yolo11s.pt \
    data=/workspace/datasets/data.yaml \
    epochs=50 \
    imgsz=640 \
    batch=16 \
    device=0

yolo export model=/workspace/runs/detect/train/weights/best.pt format=onnx

uvx copyparty