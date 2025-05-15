#!/bin/bash
# Ask the user for their name
#echo Name of user you would like to add?
#read varname
sudo adduser ben

gpasswd -a ben sudo


#echo User $varname has been added to the sudo users group. Booyah
###Switch user from root
#su - $varname

#echo What is your user name?
#read varname
echo Initializing Rstudio-Server & Shiny-Server installation!

#Get updates
sudo apt-get update -y
#Install nginx server
sudo apt-get install nginx -y

sudo apt install net-tools -y

###Install base R
#sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/" >> /etc/apt/sources.list'
###Add R public keys
#gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
#gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -

###Update again
sudo apt-get update -y
###Install base R
sudo apt-get install r-base -y

##Swap 1GB of Memory to create more space on your server
sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
sudo /sbin/mkswap /var/swap.1
sudo /sbin/swapon /var/swap.1
sudo sh -c 'echo "/var/swap.1 swap swap defaults 0 0 " >> /etc/fstab'

echo "1GB of swapspace has been added to your server"
#Install devtools dependencies                                                                                                                                         

sudo apt-get -y install libcurl4-gnutls-dev libxml2-dev libssl-dev
echo "Devtools dependencies have been installed on your server"

sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"devtools::install_github('daattali/shinyjs')\""

###Install Rstudio Server
#Install gdebi
sudo apt-get -y install gdebi-core

###Install latest version of Rstudio Server
wget https://download2.rstudio.org/server/jammy/amd64/rstudio-server-2024.12.0-467-amd64.deb
#https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.3.1056-amd64.deb
sudo gdebi rstudio-server-2024.12.0-467-amd64.deb
echo "Rstudio-Server has been installed on your server"

###Install R-Shiny dependency needed for Shiny-Server build
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""                                                                                    
###Install latest verison of R Shiny-Server
wget https://download3.rstudio.org/ubuntu-18.04/x86_64/shiny-server-1.5.22.1017-amd64.deb
#https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.14.948-amd64.deb
sudo gdebi shiny-server-1.5.22.1017-amd64.deb
echo "Shiny-Server had been installed on your server"

###Setup proper permissions for shiny and your user
sudo groupadd shiny-apps
sudo usermod -aG shiny-apps ben
sudo usermod -aG shiny-apps shiny
cd /srv/shiny-server
sudo chown -R ben:shiny-apps .
sudo chmod g+w .
sudo chmod g+s .

###Install git on your system and initiliaze it
sudo apt-get -y install git
#echo 'What is your github email address? Please place in quotes....'                                                                                                    
#read $githubemailaddress
#echo 'What is your github user name? Please place in quotes....'
#read $githubusername                                                                                                                                                    
git config --global user.email gonzalezben393@gmail.com
git config --global user.name  gonzalezben81

###Initialize git on your shiny-server
cd /srv/shiny-server
git init

##Install the Java Runtime Environment
sudo apt-get install -y default jre
###Install the Java Development Kit
sudo apt-get install -y default-jdk
##Update where R expects to find various Java files
sudo R CMD javareconf

###Ask user if they want to install additional R packages:
#while true; do
#    read -p "$varname Do you wish to install 57 additional R packages?" yn
#    case $yn in
#        [Yy]* )
sudo su - -c "R -e \"install.packages('DT', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('readr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('corrgram', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('xlsx', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('randomForest', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rgdal', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('leaflet', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('reshape', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('reshape2', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('dplyr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('httr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('jsonlite', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shinyWidgets', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rmarkdown', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('stringr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shinycssloaders', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shinythemes', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shinydashboard', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RMySQL', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('sqldf', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('scales', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('tm', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('wordcloud', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('SnowballC', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rvest', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('pander', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('ggplot2', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rhandsontable', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RPostgreSQL', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('DBI', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('formattable', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('mailR', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('ggvis', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('tree', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('BH', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('tigerstats', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('tidytext', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('syuzhet', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('pander', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RWeka', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RWekajars', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('partykit', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('qdap', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('rJava', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RMySQL', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('twitteR', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('ROAuth', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('RCurl', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('purrr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('XLConnect', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('tidyr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('lubridate', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('scales', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('stringr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('plyr', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('xtable', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shinyTime', repos='http://cran.rstudio.com/')\"";;
#        [Nn]* ) exit;;
#        * ) echo "Please answer yes or no.";;
#    esac
#done

echo  "57 additional R packages have been installed on your server!"
