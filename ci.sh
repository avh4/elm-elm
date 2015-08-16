#!/bin/bash

set -e

cd src/test
elm-test TestRunner.elm
cd ..
