#!/bin/bash
conda_command="micromamba"

# Check if the current directory is TabZilla
if [[ $(basename "$PWD") != "TabZilla" ]]; then
    echo "Error: This script must be run from the TabZilla directory."
    exit 1
fi

##############################
# begin: EXPERIMENT PARAMETERS
# maximum number of parallel processes
MAX_PROCESSES=1

# experiment name (will be appended to results files)
name=local-benchmark-gpu

# config file
config_file=tabzilla_experiment_config_missing.yml

# results file: check for results here before launching each experiment
result_log=./result_log.txt

SKLEARN_ENV="sklearn"
GBDT_ENV="gbdt"
TORCH_ENV="torch"

# Define models and their corresponding environments
MODELS_ENVS=(
    CatBoost:$GBDT_ENV
    rtdl_ResNet:$TORCH_ENV
    TabNet:$TORCH_ENV
    MLP:$TORCH_ENV
    XGBoost:$GBDT_ENV
    rtdl_MLP:$TORCH_ENV
    NODE:$TORCH_ENV
    SAINT:$TORCH_ENV
    rtdl_FTTransformer:$TORCH_ENV
)

# Define datasets
source ../scripts/HARD_REAL_DATASETS_BENCHMARK.sh

# experiment name (will be appended to results files)
experiment_name=$name

# end: EXPERIMENT PARAMETERS
############################

####################
# begin: bookkeeping

# make a log directory
mkdir -p ${PWD}/logs
LOG_DIR=${PWD}/logs

# end: bookkeeping
##################

#################
# run experiments

num_experiments=0
for i in ${!MODELS_ENVS[@]}; do
  for j in ${!DATASETS[@]}; do
    model_env="${MODELS_ENVS[i]}_tabzilla"
    model="${model_env%%:*}"
    env="${model_env##*:}"
    dataset_name=${DATASETS[j]}

    # if the experiment is already in the result log, skip it
    if grep -Fq "${dataset_name},${model},${experiment_name}" ${result_log}; then
      echo "experiment found in logs. skipping. dataset=${dataset_name}, model=${model}, expt=${experiment_name}"
      continue
    fi

    echo "MODEL_ENV: ${model_env}"
    echo "MODEL: ${model}"
    echo "ENV: ${env}"
    echo "DATASET: ${dataset_name}"
    echo "EXPERIMENT_NAME: ${experiment_name}"
    dataset_dir=./datasets/${dataset_name}
    now=$(date +"%m%d%y_%H%M%S")
    # Run the experiment locally
    (
      eval "$(${conda_command} shell hook --shell bash)"
      ${conda_command} activate $env
      echo "Python from: $(which python)"
      python tabzilla_experiment.py \
        --model_name $model \
        --experiment_config $config_file \
        --dataset_dir $dataset_dir \
        --output_dir ./results/${dataset_name}/${model} \
        >> ${LOG_DIR}/log_${i}_${j}_${model}_${dataset_name}_${now}.txt 2>&1
      
      # Check if the experiment was successful
      if [ $? -eq 0 ]; then
        # Log the successful experiment to result_log
        echo -e "${dataset_name},${model},${experiment_name}\n" >> ${result_log}
      fi
      
      ${conda_command} deactivate
    ) &

    num_experiments=$((num_experiments + 1))

    echo "${now}: launched experiment for ${model} on ${dataset_name}. (job number ${num_experiments})"
    sleep 1

    # if we have started MAX_PROCESSES experiments, wait for them to finish
    if [ $num_experiments -ge $MAX_PROCESSES ]; then
      wait
      num_experiments=0
    fi

  done
done

echo "waiting for remaining processes to finish..."
wait
echo "done."