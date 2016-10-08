#!/bin/bash

# setup system libraries for auto completion
cd ~/.vim/bundle/YCM-Generator
echo | cpp -x c++ -Wp,-v 2>&1 | grep "^ " > incllist
sed "s/ //" incllist | sed "s/\(.*\)/    '\1',/" | sed "/\//i\    '-isystem'," > incllistm
sed -i "/^flags \= \[/r incllistm"  template.py
rm incllist incllistm

