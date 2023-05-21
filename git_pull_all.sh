#!/bin/bash

git submodule foreach 'git pull'
# pull the parent
git pull
