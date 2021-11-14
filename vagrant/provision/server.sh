### Adding apt key, jenkins apt entry, and updating Package Index ###

# Add repository key to system
echo "Adding apt-keys ..."
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Add a jenkins apt repository entry
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
/etc/apt/sources.list.d/jenkins.list'

# Update local package index
sudo apt update


### Docker ###

# Install Docker
echo "Installing Docker ..."
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Pull the latest python image
sudo docker pull python

# Add a jenkins user
sudo useradd jenkins -m -G sudo,docker
sudo passwd jenkins <<EOF
jenkins
jenkins
EOF


## Install snapd and ngrok ##

# Install snapd
echo "Installing snapd ..."
sudo apt -y install snapd

# Install ngrok
echo "Installing ngrok ..."
sudo snap install ngrok


## Install java, zip, git, and jenkins ##

# Install java
echo "Installing java ..."
sudo apt -y install openjdk-11-jdk

# Install zip
echo "Installing zip ..."
sudo apt -y install zip

# Install git
echo "Installing git ..."
sudo apt -y install git

# Install git-ftp
echo "Installing git-ftp ..."
sudo apt -y install git-ftp

# Install jenkins
echo "Installing jenkins ..."
sudo apt -y install jenkins

# Start jenkins
sudo systemctl start jenkins
sleep 30

# Get the status of jenkins
sudo systemctl status jenkins

# Get the initial admin password
echo "Getting initial admin password ..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword