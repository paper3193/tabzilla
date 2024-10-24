#!/bin/bash

# mean
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_mean_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name CatBoost --output_dir fps/CatBoost_mean_fps | tee fps/CatBoost_mean_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_mean_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_ResNet --output_dir fps/rtdl_ResNet_mean_fps | tee fps/rtdl_ResNet_mean_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_mean_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_FTTransformer --output_dir fps/rtdl_FTTransformer_mean_fps | tee fps/rtdl_FTTransformer_mean_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_mean_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name XGBoost --output_dir fps/XGBoost_mean_fps | tee fps/XGBoost_mean_fps.log
# lt_min
# CUDA_VISIBLE_DEVICES=1 python tabzilla_experiment.py --experiment_config config_lt_min_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name CatBoost --output_dir fps/CatBoost_lt_min_fps | tee fps/CatBoost_lt_min_fps.log
# CUDA_VISIBLE_DEVICES=1 python tabzilla_experiment.py --experiment_config config_lt_min_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_ResNet --output_dir fps/rtdl_ResNet_lt_min_fps | tee fps/rtdl_ResNet_lt_min_fps.log
# CUDA_VISIBLE_DEVICES=1 python tabzilla_experiment.py --experiment_config config_lt_min_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_FTTransformer --output_dir fps/rtdl_FTTransformer_lt_min_fps | tee fps/rtdl_FTTransformer_lt_min_fps.log
# CUDA_VISIBLE_DEVICES=1 python tabzilla_experiment.py --experiment_config config_lt_min_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name XGBoost --output_dir fps/XGBoost_lt_min_fps | tee fps/XGBoost_lt_min_fps.log
# drop_features
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_drop_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name CatBoost --output_dir fps/CatBoost_drop_fps | tee fps/CatBoost_drop_fps.log
CUDA_VISIBLE_DEVICES=3 python tabzilla_experiment.py --experiment_config config_drop_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_ResNet --output_dir fps/rtdl_ResNet_drop_fps | tee fps/rtdl_ResNet_drop_fps.log
CUDA_VISIBLE_DEVICES=3 python tabzilla_experiment.py --experiment_config config_drop_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_FTTransformer --output_dir fps/rtdl_FTTransformer_drop_fps | tee fps/rtdl_FTTransformer_drop_fps.log
CUDA_VISIBLE_DEVICES=3 python tabzilla_experiment.py --experiment_config config_drop_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name XGBoost --output_dir fps/XGBoost_drop_fps | tee fps/XGBoost_drop_fps.log
# Binarize - not implemented
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_binarize_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name CatBoost --output_dir fps/CatBoost_binarize_fps | tee fps/CatBoost_binarize_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_binarize_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_FTTransformer --output_dir fps/rtdl_FTTransformer_binarize_fps | tee fps/rtdl_FTTransformer_binarize_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_binarize_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name rtdl_ResNet --output_dir fps/rtdl_ResNet_binarize_fps | tee fps/rtdl_ResNet_binarize_fps.log
# CUDA_VISIBLE_DEVICES=2 python tabzilla_experiment.py --experiment_config config_binarize_fps.yml --dataset_dir ./datasets/openml__fps-in-video-games__362129 --model_name XGBoost --output_dir fps/XGBoost_binarize_fps | tee fps/XGBoost_binarize_fps.log
