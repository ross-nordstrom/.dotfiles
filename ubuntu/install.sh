# Only run if we're running Ubuntu

if hash lsb_release 2>/dev/null; then
  if test "${Ubuntu#*`lsb_release -i`}" != "Ubuntu"; then
    echo 'detected ubuntu: installing base dependencies'
  else
    exit 0
  fi
else
  exit 0
fi

set -e

# Set up the time zone

echo "America/Los_Angeles" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Update Ubuntu

echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
apt-get update
apt-get upgrade

# Create a username

while true; do
    read -p "Create a new username: " user
    case $user in
        "" ) echo "Please enter a new username";;
        * ) echo "Creating $user"; break;;
    esac
done

# Add the username

adduser $user
usermod -a -G sudo $user
su $user

# Install git

apt-get install -y git

# Install vim

apt-get install -y vim

# Install node.js dependencies

apt-get install -y make python g++
apt-get install -y curl
curl http://nodejs.org/dist/v0.10.13/node-v0.10.13-linux-x64.tar.gz | tar -C /usr/local/ --strip-components=1 -zxv

# Install mon

mkdir /tmp/mon && cd /tmp/mon && curl -L# https://github.com/visionmedia/mon/archive/master.tar.gz | tar zx --strip 1 && make install

# Install spot

curl -L https://raw.github.com/guille/spot/master/spot.sh -o /usr/local/bin/spot && chmod +x /usr/local/bin/spot

# Install global node.js dependencies

npm install -g component node-gyp mongroup node-dev
