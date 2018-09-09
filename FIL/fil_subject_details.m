% This script defines the subject details for 'fil_mri_organise_batch'

%% SUBJECT DETAILS
% subject 1
subj{1}.scanid     = 'MP02312';
subj{1}.localiser  = 1;
subj{1}.structural = 2;
subj{1}.functional = 6:10;
subj{1}.motion     = []; 
subj{1}.fieldmaps  = [4 5];
subj{1}.delete     = [];

% subject 2
subj{2}.scanid     = 'MP02313';
subj{2}.localiser  = 1;
subj{2}.structural = 2;
subj{2}.functional = 6:10;
subj{2}.motion     = []; 
subj{2}.fieldmaps  = [4 5];
subj{2}.delete     = [];

%% Save details
save('subject_details.mat','subj');
% save('../analysis/subject_details.mat','subj');