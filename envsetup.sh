conda create -n PeakCalling_analysis python=3.10
conda activate PeakCalling_analysis

# Install bowtie2
conda install bowtie2
which bowtie2

# Install samtools
cd samtools-1.x    # and similarly for bcftools and htslib
chmod +x configure
apt-get install libncurses5-dev libncursesw5-dev
apt-get install libbz2-dev
apt-get install liblzma-dev
./configure --prefix=/root/.conda/envs/PeakCalling_analysis
make
make install
which samtools
# export PATH=/root/.conda/envs/PeakCalling_analysis/bin:$PATH  

# Install MACS3
git clone --recurse-submodules https://github.com/macs3-project/MACS.git
cd MACS
pip install .
which macs3

# Install deeptools
pip install deeptools
which deeptools

# Install sambamba
conda install bioconda::sambamba