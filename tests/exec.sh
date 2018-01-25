#! /usr/bin/env bash

haxe -main ALL -python tests.py -cp ../src/ && python3 tests.py
