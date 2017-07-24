model=$1
N=$2
seed=$3

for ((i = 1; i <= N; i++));
do
    echo $i
    ./$model.model sample data file=data.dump random seed=12344 id=$i  output file=data/$model-mod$i.csv &  # Need the & to sample in parallel!
done
