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
# Bad experiment name, but we're keeping it for now; to avoid breaking existing results
name=local-benchmark-lt-min-impute-gpu

# config file
CONFIGS=(
    tabzilla_experiment_config_impute_lt_min.yml
    tabzilla_experiment_config_impute_mean.yml
    tabzilla_experiment_config_impute_drop.yml
)

# results file: check for results here before launching each experiment
result_log=./result_log.txt

SKLEARN_ENV="sklearn"
GBDT_ENV="gbdt"
TORCH_ENV="torch"

# Define models and their corresponding environments
MODELS_ENVS=(
    CatBoost:$GBDT_ENV
    rtdl_ResNet:$TORCH_ENV
    XGBoost:$GBDT_ENV
    rtdl_FTTransformer:$TORCH_ENV
)

# Define datasets
source ../scripts/MISSING_DATASETS_SMALL_BECNHMARK.sh
DATASETS=("${DATASETS_A[@]}")

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
for j in ${!DATASETS[@]}; do
  for i in ${!MODELS_ENVS[@]}; do
    for k in ${!CONFIGS[@]}; do
        model_env="${MODELS_ENVS[i]}_tabzilla"
        model="${model_env%%:*}"
        env="${model_env##*:}"
        dataset_name=${DATASETS[j]}
        config_file=${CONFIGS[k]}
        config_file_name=${config_file%.*}

        # if the experiment is already in the result log, skip it
        if grep -Fq "${dataset_name},${model},${experiment_name},${config_file_name}" ${result_log}; then
        echo "experiment found in logs. skipping. dataset=${dataset_name}, model=${model}, expt=${experiment_name}, config=${config_file_name}"
        continue
        fi

        echo "MODEL_ENV: ${model_env}"
        echo "MODEL: ${model}"
        echo "ENV: ${env}"
        echo "DATASET: ${dataset_name}"
        echo "EXPERIMENT_NAME: ${experiment_name}"
        echo "CONFIG_FILE: ${config_file}"
        output_dir="./results/${config_file_name}/${dataset_name}/${model}"
        echo "OUTPUT_DIR: ${output_dir}"
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
            --output_dir $output_dir \
            >> ${LOG_DIR}/log_${i}_${j}_${model}_${dataset_name}_${now}.txt 2>&1
        
        # Check if the experiment was successful
        if [ $? -eq 0 ]; then
            # Log the successful experiment to result_log
            experiment_hash="${dataset_name},${model},${experiment_name},${config_file_name}"
            echo -e "${experiment_hash}" >> ${result_log}
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
done

echo "waiting for remaining processes to finish..."
wait
echo "done."