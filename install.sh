#to install write ./install.sh
#installing myterminal.sh

cp myterminal.sh ~/.bash_profile
cp .gitignore ~/.gitignore
echo "" >> ~/.bashrc
echo "#custom terminal" >> ~/.bashrc
echo "source .bash_profile\n" >> ~/.bashrc
sudo su
echo "" >> ~/.bashrc
echo "#custom terminal" >> ~/.bashrc
echo "source .bash_profile\n" >> ~/.bashrc
exit
source ~/.bashrc
exit