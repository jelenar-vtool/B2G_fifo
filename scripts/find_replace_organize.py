#!/usr/bin/env python3

import glob, os
import argparse
import sys

parser = argparse.ArgumentParser(description='Sets up a UVC file hierarchy from the template. \
			                                  Changes the names of the files and UVC classes \
			                                  with the names given by the user.')
			     
parser.add_argument('-temp_dir', nargs=1, help='Path to the template files')
parser.add_argument('-uvc_dir', nargs=1, help='Path to where the UVC files will be saved')
parser.add_argument('-temp_name', nargs=1, help='The name used in template (default is "temp"')
parser.add_argument('-uvc_name', nargs=1, help='The UVC name ("temp" will be replaced in all files with this)')

args = parser.parse_args()

start_dir = os.curdir
temp_dir = start_dir
temp_name = "temp"
uvc_create_dir = start_dir
uvc_root_dir = start_dir
uvc_name = "uvc"

if args.temp_dir != None:
    if os.path.isdir(args.temp_dir[0]):
        temp_dir = os.path.abspath(args.temp_dir[0])
print(f'Template directory: {temp_dir}')

if args.temp_name != None:
    temp_name = args.temp_name[0]
print(f'Template name is: {temp_name}')

if args.uvc_name != None:
    uvc_name = args.uvc_name[0]
print(f'UVC name is: {uvc_name}')

if args.uvc_dir != None:
    if os.path.isdir(args.uvc_dir[0]):
        uvc_create_dir = os.path.abspath(args.uvc_dir[0])

uvc_root_dir = f'{uvc_create_dir}//{uvc_name}_uvc'

cont = 'x'
if os.path.isdir(uvc_root_dir):
    cont = input(f'NOTE: Directory {uvc_root_dir} already exists.\nSome/all files will be overwriten by files found in template. Continue? (y/n)')
    while cont not in ['y', 'Y', 'n', 'N']:
        cont = input('Please answer by typing y or n - ')

if(cont in ['n', 'N']):
    print('Aborted.')
    sys.exit(0)

uvc_env_dir = f'{uvc_root_dir}//env'
uvc_dir = f'{uvc_root_dir}//uvc'
uvc_tests_dir = f'{uvc_root_dir}//tests'
uvc_tb_dir = f'{uvc_root_dir}//tb'

if not os.path.isdir(uvc_root_dir):
    os.mkdir(uvc_root_dir)
if not os.path.isdir(uvc_env_dir):
    os.mkdir(uvc_env_dir)
if not os.path.isdir(uvc_dir):
    os.mkdir(uvc_dir)
if not os.path.isdir(uvc_tests_dir):
    os.mkdir(uvc_tests_dir)
if not os.path.isdir(uvc_tb_dir):
    os.mkdir(uvc_tb_dir)

print(f'UVC directory: {os.path.abspath(uvc_root_dir)}')

os.chdir(temp_dir)

file_list = [f for f in glob.glob("*.sv")]
print("Found the following template .sv files: ")
print(file_list)

for f in file_list:
    with open(f, 'r') as file:
        filedata = file.read()

    filedir = uvc_dir
    if(temp_name not in f):
        filedir = uvc_tb_dir
    if(('env' in f) or ('scoreboard' in f) or ('env' in f)):
        filedir = uvc_env_dir
    if('test' in f):
        filedir = uvc_tests_dir
        
    filedata = filedata.replace(temp_name, uvc_name)
    
    new_file = f.replace(temp_name, uvc_name)
    with open(f'{filedir}//{new_file}', 'w') as file:
        file.write(filedata)

os.chdir(start_dir)
