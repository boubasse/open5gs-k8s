#!/bin/bash
is_base_not_built=$(docker image ls | grep open5gs-base)

if [ -z "$is_base_not_built" ]
then
    docker build -t open5gs-base:latest base/
fi

for image_dir in */
    do
        if [ $image_dir != "base" ]
        then
            echo "Building ${image_dir} ..."
            docker build -q -t open5gs-${image}:latest $image_dir/
            echo "Image has been successfully built"
        fi
    done