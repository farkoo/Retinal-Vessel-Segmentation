close all; clc;

addpath(genpath('./data'));
addpath(genpath('./functions'));


tic;

file_path_im = './DRIVE/Test/images/';         
file_path_manual = './DRIVE/Test/1st_manual/'; 
im_postfix = '*.tif';     
ma_postfix = '*.gif';   

dataset_test(file_path_im, file_path_manual, im_postfix, ma_postfix);

toc;