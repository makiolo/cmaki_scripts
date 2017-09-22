@echo off
cd node_modules\cmaki_generator
build --yaml=..\..\cmaki.yml --server=http://artifacts.myftp.biz:8080
cd ..
