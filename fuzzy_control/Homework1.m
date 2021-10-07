clc;
clear;

fis = mamfis('Name',"inventory");

fis = addInput(fis,[0 0.7],'Name',"mean_delay");
fis = addMF(fis,"mean_delay","trapmf",[0 0 0.1 0.3],'Name',"VS");
fis = addMF(fis,"mean_delay","trimf",[0.1 0.3 0.5],'Name',"S");
fis = addMF(fis,"mean_delay","trapmf",[0.4 0.6 0.7 0.7],'Name',"M");

fis = addInput(fis,[0 1],'Name',"number_of_servers");
fis = addMF(fis,"number_of_servers","trapmf",[0 0 0.25 0.35],'Name',"S");
fis = addMF(fis,"number_of_servers","trimf",[0.3 0.5 0.7],'Name',"M");
fis = addMF(fis,"number_of_servers","trapmf",[0.6 0.8 1 1],'Name',"L");

fis = addInput(fis,[0 1],'Name',"utilisation_factor");
fis = addMF(fis,"utilisation_factor","trapmf",[0 0 0.4 0.6],'Name',"L");
fis = addMF(fis,"utilisation_factor","trimf",[0.4 0.6 0.8],'Name',"M");
fis = addMF(fis,"utilisation_factor","trapmf",[0.6 0.8 1 1],'Name',"H");

fis = addOutput(fis,[0 1],'Name',"number_of_spares");
fis = addMF(fis,"number_of_spares","trapmf",[0 0 0.1 0.3],'Name',"VS");
fis = addMF(fis,"number_of_spares","trimf",[0 0.2 0.4],'Name',"S");
fis = addMF(fis,"number_of_spares","trimf",[0.25 0.35 0.45],'Name',"RS");
fis = addMF(fis,"number_of_spares","trimf",[0.3 0.5 0.7],'Name',"M");
fis = addMF(fis,"number_of_spares","trimf",[0.55 0.65 0.75],'Name',"RL");
fis = addMF(fis,"number_of_spares","trimf",[0.6 0.8 1],'Name',"L");
fis = addMF(fis,"number_of_spares","trapmf",[0.7 0.9 1 1],'Name',"VL");

ruleList = [1 1 1 1 1 1; 2 1 1 1 1 1; 3 1 1 1 1 1
           1 2 1 1 1 1; 2 2 1 1 1 1; 3 2 1 1 1 1
           1 3 1 2 1 1; 2 3 1 2 1 1; 3 3 1 1 1 1
           1 1 2 2 1 1; 2 1 2 1 1 1; 3 1 2 1 1 1
           1 2 2 3 1 1; 2 2 2 2 1 1; 3 2 2 1 1 1
           1 3 2 4 1 1; 2 3 2 3 1 1; 3 3 2 2 1 1
           1 1 3 7 1 1; 2 1 3 6 1 1; 3 1 3 4 1 1
           1 2 3 4 1 1; 2 2 3 4 1 1; 3 2 3 2 1 1
           1 3 3 5 1 1; 2 3 3 4 1 1; 3 3 3 3 1 1];
figure(1);
fis = addRule(fis,ruleList);
opt = gensurfOptions('InputIndex',[2 1]);
gensurf(fis, opt)
figure(2);
opt = gensurfOptions('InputIndex',[3 1]);
gensurf(fis, opt)

