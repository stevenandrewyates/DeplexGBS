
##################################################
######            Details                   ######
##################################################

# author:   Steven Yates
# contact:  steven.yates@usys.ethz.ch
# Year:     2021
# Citation: TBA

##################################################
######            Description               ######
##################################################

# a method for deplexing genotyping-by-sequencing 
# data using the euler computing system at ETH

# http://scicomp.ethz.ch/wiki/Euler
##################################################
######              Usage                   ######
##################################################

# best to run this interactively!
# login to Euler 
# copy the data to a scratch folder
# this can be found using
# echo $SCRATCH
# Perhaps something is not working?
# please see at the bottom for some trouble shooting

##################################################
######              Script                  ######
##################################################

# first login to Euler, using putty or ssh (for linux)
# if you are unsure please read this
# https://scicomp.ethz.ch/wiki/Euler

# now go to the folder in your scratch

cd $SCRATCH/folder

# next you need to load the git module (to download the scripts)

module load git

# next install sabre

git clone https://github.com/najoshi/sabre
cd sabre
make

# check it works
./sabre

# go back to the beginning
cd $SCRATCH/folder

# now download this repository (it has the barcodes)

git clone https://github.com/stevenandrewyates/DeplexGBS


# one last thing before deplexing, 
# you need a folder to store it in
# in this example (an in reality),
# let's call it DEPLEX

mkdir DEPLEX

# you now have everything you need to deplex the data
# you need your GBS data, in this example it is called 
# GBSdata.fastq

# Deplexing will also create two more files
# unknown_barcode.fastq, a file with unallocated reads
# summaryLibrary1.txt, a summary file

sabre/sabre se -f GBSdata.fastq -b DeplexGBS/Library1.barcodes.txt -u unknown_barcode.fastq  >> summaryLibrary1.txt

# Voila, finished

##################################################
######           Trouble shooting           ######
##################################################

# Finally some tips!
# You probably have a zipped file with data, which needs unzipping
# use zcat to do this

zcat ZIPPED.data.fastq.gz > GBSdata.fastq

# Now let's suppose you have multiple files.
# Meaning multiple runs of the same library,
# you can easily combine these all inot one file

zcat RUN2.data.fastq.gz >> GBSdata.fastq

# please note the ">>" is used to 
# append the data "RUN2.data.fastq.gz" 
# to an existing file "GBSdata.fastq"
# if the file doesn't exist it will create it 
# also note that if you do this multiple times you will multiply the data

