#!/bin/bash

for module in */; do
	pushd $module
	git checkout master && git pull
	popd
done
