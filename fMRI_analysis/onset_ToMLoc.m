%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Making .mat files for first level fMRI analysis (ToM localiser)
% Author: Anna Hudson
% Date: 30/01/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
clear
cd ('H:/Anna/2017/Study 2 (fMRI)/Study_2_March_2016/Data/Logfiles/TomLoc/Onsetfiles');
files_dir = dir('Onset_ppt*');
files = {files_dir.name};
names = cell(1,2);
onsets = cell(1,2);
durations = cell(1,2);
names{1} = 'FalseBelief';
names{2} = 'FalsePhoto';
durations{1} = 20; % Including both the question and the answer phase
durations{2} = 20;

for i = 76    % 1:length(files)
    onsets_file = files{i};
    onsets_text = textread(onsets_file,'%s','delimiter','\n');
    onsets_belief = char(strread(char(onsets_text(1)),'%s','delimiter','\t'));
    onsets_photo = char(strread(char(onsets_text(2)),'%s','delimiter','\t'));
    onsets_belief_final = str2num(onsets_belief(2:end,:));
    onsets_photo_final = str2num(onsets_photo(2:end,:));
    onsets{1} = onsets_belief_final;
    onsets{2} = onsets_photo_final; 
    filename = strcat('Cons_localiser_ppt',num2str(i),'.mat');
    save(filename,'names','onsets','durations');
end
