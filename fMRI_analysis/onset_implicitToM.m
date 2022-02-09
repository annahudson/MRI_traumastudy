%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Making .mat files for first level fMRI analysis
% Author: Anna Hudson
% Date: 30/01/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
clear
% cd ('H:/Anna/2017/Study 2 (fMRI)/Study_2_March_2016/Data/Logfiles/ImplicitToM/Onsetfiles_run1');
cd ('H:/Anna/2017/Study 2 (fMRI)/Study_2_March_2016/Data/Logfiles/ImplicitToM/Onsetfiles_run2');
files_dir = dir('Onset_ppt*');
files = {files_dir.name};
names = cell(1,4);
onsets = cell(1,4);
durations = cell(1,4);
names{1} = 'PminAplus';
names{2} = 'PplusAmin';
names{3} = 'PminAmin';
names{4} = 'PplusAplus';
durations{1} = 9; % For the belief formation phase, durations = 9; for the outcomes, durations = 0
durations{2} = 9;
durations{3} = 9;
durations{4} = 9; 

for i = 76    % 1:length(files)
    onsets_file = files{i};
    onsets_text = textread(onsets_file,'%s','delimiter','\n');
    onsets_pmin_amin = char(strread(char(onsets_text(1)),'%s','delimiter','\t'));
    onsets_pmin_aplus = char(strread(char(onsets_text(2)),'%s','delimiter','\t'));
    onsets_pplus_amin = char(strread(char(onsets_text(3)),'%s','delimiter','\t'));
    onsets_pplus_aplus = char(strread(char(onsets_text(4)),'%s','delimiter','\t'));
    onsets_pminamin_final = str2num(onsets_pmin_amin(2:end,:));
    onsets_pminaplus_final = str2num(onsets_pmin_aplus(2:end,:));
    onsets_pplusamin_final = str2num(onsets_pplus_amin(2:end,:));
    onsets_pplusaplus_final = str2num(onsets_pplus_aplus(2:end,:));
    onsets{1} = onsets_pminaplus_final;    
    onsets{2} = onsets_pplusamin_final;
    onsets{3} = onsets_pminamin_final;
    onsets{4} = onsets_pplusaplus_final;
    % filename = strcat('Cons_run1_all_ppt',num2str(i),'.mat');
    filename = strcat('Cons_run2_all_ppt',num2str(i),'.mat');
    save(filename,'names','onsets','durations');
end
