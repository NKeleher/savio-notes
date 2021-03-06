#!/bin/bash
######### Sbatch configuration.
#
# NOTE: we do not specify account, partition, or QOS in this file,
# in order to allow easier customization. Instead those settings
# should be specified in the command line via the calling file.
#
# Job output
#SBATCH --output=slurm.out
#SBATCH --error=slurm.out
#
# Wall clock limit:
#SBATCH --time=48:00:00
#
#### Done configuring sbatch.

# Output to current directory by default. Overriden by --dir option.
dir_output=.

# Extract command line arguments
for i in "$@"
do
case $i in
    -f=*|--file=*)
    file="${i#*=}"
    ;;
    -d=*|--dir=*)
    dir_output="${i#*=}"
    ;;
esac
done

# Load R if we are using the built-in R module:
# Here we are using a custom compiled version of R, so we don't load the r module.
# module load r

# Load a newer version of gcc than the default.
module load gcc/4.8.5 java lapack

R CMD BATCH --no-save --no-restore ${file} ${dir_output}/${file}.out
