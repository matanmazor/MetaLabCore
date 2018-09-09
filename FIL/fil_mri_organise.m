function fil_mri_organise(which_subjects)
% function fil_mri_organise(which_subjects)
% Sorts unzipped folders and deletes dummy volumes
% Details for each subject must be entered in 'fil_subject_details'
% If the data for a subject has already been sorted, then that subject
% is skipped
% which_subjects is a vector
%
% Steve Fleming & Dan Bang, FIL, 07/06/2016
% Ammended by Matan Mazor, FIL, 09/09/2018

%% Current directory
cwd = pwd;

% Load project params file. 
% IMPORTANT: this file should be edited before using this script. 
load('D:\Documents\software\MetaLabCore\project_params.mat');

%% Load subject details (see fil_subject_details)
load(fullfile(project_params.raw_dir,'subject_details.mat'));

%% Add SPM directory
addpath(project_params.spm_dir);

%% Loop through scans
for i_s = which_subjects;
    % unzip data if not unzipped yet
    if ~isdir(fullfile(project_params.data_dir,'s',num2str(i_s)))
        %find relevant dir
        raw_dirs = cellstr(ls(project_params.raw_dir));
        indexC = strfind(raw_dirs, subj{i_s}.scanid);
        index = find(not(cellfun('isempty', indexC)));
        %unzip
        fil_mri_unzip(raw_dirs{index},i_s)
    end
        
    
    %% localiser
    % paths
    if not(isempty(subj{i_s}.localiser))
        
        old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                    strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.localiser)));
        new_path  = fullfile(project_params.data_dir,'s',...
                    strcat('sub-',subj{i_s}.scanid),'loc');

        % reorganise
        reorganize(old_path, new_path,1);
        
    end
    
    %% structural
    % paths
    old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.structural)));
    new_path  = fullfile(project_params.data_dir,'s',...
                strcat('sub-',subj{i_s}.scanid),'anat');
    % reorganise
    reorganize(old_path, new_path,1)
    
    %% functional
    % loop through functional scans
    n_fun = length(subj{i_s}.functional); %number of functional runs
    for j = 1:n_fun;
        % paths
        old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.functional(j))));    
        new_path  = fullfile(project_params.data_dir,'s',...
                strcat('sub-',subj{i_s}.scanid),'func', strcat('run-',num2str(j)));
        % reorganise
        reorganize(old_path, new_path,1)
        fname   = spm_select('List', new_path, '^f.*\.nii$');
        
        %delete dummy scans
        for d = 1:project_params.n_dum; 
            delete(fullfile(new_path,fname(d,:))); 
            fprintf('Deleted dummy scan %s.\n',fname(d,:)); 
        end; 
    end
    
    %% fieldmaps
    for j = 1:n_fun
        % maps 1-2 (phase)
        % paths
        old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.fieldmaps(1))));    
        new_path  = fullfile(project_params.data_dir,'s',...
                strcat('sub-',subj{i_s}.scanid),'func', strcat('run-',num2str(j)));
        % reorganise
        reorganize(old_path, new_path,0);
        
        % map 3 (magnitude)
        old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.fieldmaps(2))));    
        new_path  = fullfile(project_params.data_dir,'s',...
                strcat('sub-',subj{i_s}.scanid),'func', strcat('run-',num2str(j)));
        % reorganise
        reorganize(old_path, new_path,0);
        
    end
    
    %% delete field maps
    for i = 1:2
        old_path  = fullfile(project_params.data_dir,'s',num2str(i_s),...
                strcat(subj{i_s}.scanid, '_FIL.S', num2str(subj{i_s}.fieldmaps(i))));
        if exist(old_path,'dir')==7 
            rmdir(old_path,'s'); 
        end
    end
        
    %% delete rest
    old_path = fullfile(project_params.data_dir,'s',num2str(i_s));
    if exist(old_path,'dir')==7
        rmdir(old_path,'s')
    end
    
end

cd(cwd);
end