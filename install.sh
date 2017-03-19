#/bin/bash
echo running command: "cmake CMakeLists.txt"
cmake CMakeLists.txt
echo *** running command: "make"
make
echo *** running command: "sudo make install"
sudo make install
