declare -a models=("line" "transformed-line" "transformed-scaled-line")

python rdump.py

RANDOM_SEED=124456

for model in "${models[@]}"
do
for i in {1..4}
do
    time ./$model.model sample data file=data.dump \
        random seed=$RANDOM_SEED \
        id=$i \
        output file=data/$model-$i.csv &
done
done