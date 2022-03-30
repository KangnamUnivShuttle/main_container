#! /bin/bash

jingisukan new --cpu=0.1 --ram=128M --name=asdfasdf --port=10000 --path='.'
jingisukan dockerfile --url=https://github.com/KangnamUnivShuttle/plugin_hello_world.git --name=asdfasdf --path=.
jingisukan ecosystem --name=asdfasdf --path=.