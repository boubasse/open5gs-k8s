#!/bin/bash
is_base_not_built=$(docker image ls | grep open5gs-base)

if [ -z "$is_base_not_built" ]
then
    docker build -t open5gs-base:latest base/
fi

for image_dir in */
    do
	image_dir_clean=$(echo $image_dir | sed 's/.$//')
        if [ $image_dir_clean != "base" ]
        then
            echo "Building ${image_dir_clean} ..."
            docker build -q -t open5gs-${image_dir_clean}:latest $image_dir_clean/
            echo "Image has been successfully built"
        fi
    done
