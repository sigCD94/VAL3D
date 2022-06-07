# Installation de IfcConverter - OpenShell
curl https://s3.amazonaws.com/ifcopenshell-builds/IfcConvert-v0.7.0-1b1fd1e-linux64.zip;
unzip IfcConvert-v0.7.0-1b1fd1e-linux64;
rm -rf IfcConvert-v0.7.0-1b1fd1e-linux64.zip;

# Installation of COLLADA2GLTF
git clone --recursive https://github.com/KhronosGroup/COLLADA2GLTF.git;
cd COLLADA2GLTF;
mkdir build;
cd build;
cmake ..;
make
