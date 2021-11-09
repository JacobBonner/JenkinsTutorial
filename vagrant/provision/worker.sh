# {

### Update Package Index and Install Java ###

cd /home/vagrant

# Update local package index
sudo apt update 

# Install java
echo "Installing java ..."
sudo apt install default-jre -y


### Docker ###

# Install Docker
echo "Installing Docker ..."
sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Pull the latest ____ image
sudo docker pull python

# Configure the target system docker for web/REST access, by appending '-H tcp://0.0.0.0:4243' 
# to the 'Start' or 'ExecStart' parameter of the file '/lib/systemd/system/docker.service'.
dock_serv=/lib/systemd/system/docker.service
linenum=$( grep -n "ExecStart=" $dock_serv | cut -d : -f1 )
line=$(sed -n $linenum'p' $dock_serv)
line_change=$linenum's'
sudo sed -i "$line_change#.*#$line -H tcp://0.0.0.0:4243#" $dock_serv

# Restart the docker service
sudo systemctl daemon-reload
sudo systemctl restart docker


### Configure SSH ###

# Create private and public SSH keys
cd ~/.ssh/
ssh-keygen -t rsa -f "jenkinsAgent_rsa"

# Add the public SSH key to the list of authorized keys on the agent machine
cat jenkinsAgent_rsa.pub >> ~/.ssh/authorized_keys

# Ensure that the permissions of the ~/.ssh directory is secure
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys ~/.ssh/jenkinsAgent_rsa

#} &> /dev/null