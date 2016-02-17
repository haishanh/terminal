#!/bin/bash

POST_DIR=../source/_posts

# MAIN
cd $POST_DIR
posts=$(ls)
for post_name in $posts; do
  new_name=$(echo $post_name | sed 's/_/-/g')
  if [ $new_name != $post_name ]; then
    mv $post_name $new_name
  fi
done
