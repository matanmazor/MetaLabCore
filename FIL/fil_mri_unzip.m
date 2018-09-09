function fil_mri_unzip(FIL_id,subject)
% function fil_mri_unzip(FIL_id,subject)
%
% Unzips the data from Charm, where FIL_id is scan ID and subject is the
% subject number in the study (starting at 1).
%
% Note that this function only works on FIL computer as that is the only
% place where I store the zipped data (saving space).
%
% Steve Fleming & Dan Bang, FIL, 07/06/2016

% current directy
cwd = pwd;

% load project params file. 
% IMPORTANT: this file should be edited before using this script.
load('D:\Documents\software\MetaLabCore\project_params.mat');


% add import tool
addpath(fullfile(project_params.spm_dir, 'toolbox','Import_Archive'));

% unzip data in this folder
zipped   = fullfile(project_params.raw_dir ,FIL_id);

% place unzipped data in this folder
unzipped = fullfile(project_params.data_dir ,'s',num2str(subject));

% error if exist
if exist(unzipped,'dir'); error('--already unzipped'); else mkdir(unzipped); end;

% error if not at the FIL
[~,name] = system('hostname');
% MM: Change to your FIL computer name (the name on the sticker attached
% to your PC)
if ~strcmp(name(1:end-1),project_params.hostname); error('--only works at the FIL'); end;

% get folder names for unzipping
cd(zipped);
dirinfo = dir;

% loop through
for i = 3:size(dirinfo)
   Import_Archive(dirinfo(i).name,unzipped);
end

cd(cwd);

end