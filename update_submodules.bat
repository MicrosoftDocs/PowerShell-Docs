#git submodule update --recursive
#git submodule foreach git pull origin master
#git pull --recurse-submodules
#git submodule foreach git fetch --progress --all
git submodule foreach "git pull origin master || git pull origin main || git pull origin atari || :"
