BAD=(
    openml__Bioresponse__9910 # Deterministic
    openml__MiniBooNE__168335 # Deterministic ?
    openml__artificial-characters__14964 # Generated
    openml__balance-scale__11 # Generated ?
    openml__higgs__146606 # Generated
    openml__jungle_chess_2pcs_raw_endgame_complete__167119 # Deterministic
    openml__monks-problems-2__146065 # Deterministic
    openml__nomao__9977 # Seems deterministic
    openml__one-hundred-plants-texture__9956 # Should be done with CNN
    openml__poker-hand__9890 # Deterministic
    openml__qsar-biodeg__9957 # Deterministic ?
    openml__splice__45 # Deterministic ?
)

LESS_COMPELLING=(
    openml__SpeedDating__146607 # Binary - not convinced there is a signal
    openml__airlines__189354 # Binary - not convinced there is a signal
    openml__cnae-9__9981 # Multiclass - is essentially BoW output
    openml__electricity__219 # Binary - up/down electricity prices
    openml__elevators__3711 # Binary - no info on the dataset
    openml__heart-h__50 # Binary - but the original task is multiclass; unclear what has happened to dataset
    openml__jasmine__168911 # Binary - no info on the dataset
    openml__lymph__10 # Multiclass - very small dataset with few variables
    openml__mfeat-fourier__14 # Multiclass - basically MNIST
    openml__mfeat-zernike__22 # Multiclass - basically MNIST
    openml__phoneme__9952 # Small dataset and it is unclear what the task is
    openml__socmob__3797 # Binary - no info on the dataset
    openml__vehicle__53 # Multiclass - cool but should be done with CNN
)

DATASETS=(
    openml__Australian__146818 # Binary
    openml__GesturePhaseSegmentationProcessed__14969 # Multiclass
    openml__ada_agnostic__3896 # Binary
    openml__albert__189356 # Binary, 4Paradigm
    openml__audiology__7 # Multiclass
    openml__colic__25 # Binary
    openml__credit-approval__29 # Binary, kinda old
    openml__credit-g__31 # Binary
    openml__guillermo__168337 # Binary, 4Paradigm
    openml__kc1__3917 # Binary
    openml__profb__3561 # Binary
)