#! /bin/bash

zip -r main_container.zip *

scp -P 2022 main_container.zip stories2@kws1.kangnam.ac.kr:/home/stories2/

rm main_container.zip