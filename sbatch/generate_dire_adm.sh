#!/bin/bash

#SBATCH --job-name=compute-dire
#SBATCH --time 12:00:00
#SBATCH --tmp=20G
#SBATCH --ntasks=2
#SBATCH --mem-per-cpu=4G
#SBATCH --gpus=a100_80gb:1

COMPRESSED_FOLDER_PATH="/cluster/scratch/$USER/dalle_2.tar.gz"

module load gcc/8.2.0 python_gpu/3.10.4 eth_proxy
wandb login
pip install . src/guided-diffusion
rsync -chavzP $COMPRESSED_FOLDER_PATH $TMPDIR/images.tar
mkdir -p $TMPDIR/images
tar xf $TMPDIR/images.tar -C $TMPDIR/images 
python scripts/generate_dire.py --ddim_steps 10 --batch_size 20 --write_dir_dire "/cluster/scratch/$USER/dalle_2_dire_10_steps" --write_dir_latent_dire "/cluster/scratch/$USER/dalle_2_latent_dire_10_steps"