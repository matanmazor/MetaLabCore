function fil_fieldmap_preprocess(which_subjects)
% function fil_fieldmap_preprocess(which_subjects)
%
% Script calling SPM's fieldmap_preprocess for multi-subject, 
% multi-session datasets (NB: reorient images first in SPM).
%
% Fieldmap_preprocess creates a single fieldmap (fpm5_*.), converts it to
% a voxel displacement file (vdm5_*.), and matches the vdm5 file to the
% first EPI image from each run.
%
% For multiple sessions, copies of original fieldmaps should be present in 
% each of dir_fieldmap/session* directories. This allows each session to have
% individual Match VDM to EPI maps.
% 
% See http://intranet.fil.ion.ucl.ac.uk/wiki/physicswiki/doku.php?id=start:data_processing:using_field_maps
% for further information [MUST BE ON FIL NETWORK TO READ]
%
% which_subjects is a vector
%
% Steve Fleming & Dan Bang, FIL, 07/06/2016
% Ammended by Matan Mazor, 09/09/2018


%%  load project params file. 
% IMPORTANT: this file should be edited before using this script. 
load('D:\Documents\software\MetaLabCore\project_params.mat');

load(fullfile(project_params.raw_dir,'subject_details.mat'));

%% Add SPM directory
addpath(project_params.spm_dir);

%% Fieldmap_preprocess parameters (see help Fieldmap_preprocess for details) 
te1             = 10.0;     % short echo time 
te2             = 12.46;    % long echo time
epifm           = 0;        % epi-based fieldmap (1/0)
tert            = 36;       % total echo (EPI) readout time -- see EPI sequence
kdir            = -1;       % blip direction (+1/-1) -- see EPI sequence
mask            = 1;        % (optional flag, default=1) Do brain masking or not (only if non-epi fieldmap)
match           = 1;        % (optional flag, default=1) Match fieldmap to epi or not

% loop through all subjects and sessions
%===========================================================================
for i_s = which_subjects
   
    % display current subject
    fprintf(['====SUBJECT ',num2str(i_s),': fieldmap pre-processing\n']);
    
    % functional
    for j = 1:numel(subj{i_s}.functional)
        % find folders
        fm_dir = fullfile(project_params.data_dir,'s',strcat('sub-',subj{i_s}.scanid),...
                            'func',strcat('run-',num2str(j)));
        epi_dir = fullfile(project_params.data_dir,'s',strcat('sub-',subj{i_s}.scanid),...
                            'func',strcat('run-',num2str(j)));
                        
        % run fieldmap_preprocess
        FieldMap_preprocess(fm_dir,epi_dir,[te1, te2, epifm, tert, kdir, mask, match]);
        fprintf(['....pre-processing completed for main task block ',num2str(j),'\n']);
    end
    
end

end