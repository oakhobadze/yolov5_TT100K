#!/bin/bash
#SBATCH --job-name=tt100k_yolo_train_100_epochs
#SBATCH --output=logs/train_output4.log
#SBATCH --error=logs/train_error4.log
#SBATCH --partition=dgx
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=24:00:00

# Активация виртуального окружения venv (не conda)
source ~/yolovenv/bin/activate

# Переменные окружения для CUDA
export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True
export CUDA_VISIBLE_DEVICES=0

# Переход в директорию с YOLOv5
cd ~/yolov5

# Запуск тренировки (убрали --device 0, чтобы избежать ошибки)
python train.py --img 640 --batch 16 --epochs 100 \
  --data dataset/mydata/YOLOv5_TT100K.yaml \
  --cfg models/yolov5s.yaml \
  --weights '' \
  --name tt100k_yolov5s_from_scratch
