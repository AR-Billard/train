#!/bin/sh

run() {
    index="$1"
    url="$2"
    basemodel="$3"
    epochs="$4"
    name="dataset $index"

    # 모델별 폴더안에서
    mkdir -p "/workspace/$name" && cd "/workspace/$name"
    pwd

    # 데이터셋 다운받고
    filename="dataset.zip"
    curl -L "$url" > "$filename"
    unzip $filename

    # 학습돌림
    uvx --from ultralytics yolo train data=data.yaml model="$basemodel" epochs="$epochs" lr0=0.01

    # 모델 찾아서 onnx로 변환. half 한거 안한거 둘다
    model="$(find . -name "best.pt" -print -quit)"
    uvx --from ultralytics yolo export model="$model" format=onnx simplify=True opset=12 nms=False name="model32.onnx"
    uvx --from ultralytics yolo export model="$model" format=onnx simplify=True opset=12 half=True nms=False name="model16.onnx"
}

pwd
index=0
epochs="$1"
shift 1
while [ "$#" -gt 0 ]; do
    url="$1"
    basemodel="$2"
    
    run "$index" "$url" "$basemodel" "$epochs"
    
    index=$((index + 1))
    shift 2
done

# 완료되면 다운받을 수 있게 webui 켜놓음
cd /workspace && uvx copyparty


