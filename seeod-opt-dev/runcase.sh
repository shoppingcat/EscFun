#/bin/bash
# This script adds SeeGeometry to the current path. 
# It works with both Bash and Zsh.
#SeeGeometry runs on MacOS & Linux. 
SEEGEOMETRY_ROOT_DIR=$(cd "$(dirname "$0")";pwd)
echo ${SEEGEOMETRY_ROOT_DIR}
export PATH=$SEEGEOMETRY_ROOT_DIR/bin:$PATH
# Add 3rdparty libraries to LD_LIBRARY_PATH variable
# Since we have added the following paths to ld, remember
# in Makfefile, we use -Wl,rpath option(ONLY VALID FOR LINUX)!!!
# It's not necessary to use LD_LIBRARY_PATH envirenment varibale,
# however, we use LD_LIBRARY_PATH again to be on the safe side.
if [ `uname  -s` = 'Darwin' ];then
    echo "MacOS envirenment varibales setting......done"
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/jsoncpp:$DYLD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/boost:$DYLD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/matlab:$DYLD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/mkl:$DYLD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/icu:$DYLD_LIBRARY_PATH
	export DYLD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/macos/protobuf:$DYLD_LIBRARY_PATH
elif [ `uname  -s` = 'Linux' ];then
    echo "Linux envirenment varibales setting......done"
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/jsoncpp:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/boost:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/matlab:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/mkl:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/icu:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$SEEGEOMETRY_ROOT_DIR/ext/lib/linux/protobuf:$LD_LIBRARY_PATH
#    echo ${LD_LIBRARY_PATH}
else
    echo 'Unsupported OS' 
fi

if [ $1 ];then
	ods -h
	exit 0
fi
time3=$(date "+%Y-%m-%d %H:%M:%S")
echo "Starting time: $time3"
export OMP_NUM_THREADS=8
bin/ods  \
    --modelfile testsuite/0-double-gauss/double-gauss.zmx2021.xml \
    --calcontent Optimization \
    --opttype 3 \
    --computetype 1
    #opttype For optimization computing:
    #  0 -- Damped Least Squares
    #  1 -- Simulated_Annealing
    #  2 -- Genetic Algorithm
    #  3 -- Escape Function
    #computetype:
    #Invoke from where:
    #0 -- from web site/front end
    #1 -- from command line/back end
    
 
time4=$(date "+%Y-%m-%d %H:%M:%S")
echo "Finishing time: $time4"
