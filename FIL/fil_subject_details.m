% This script defines the subject details for 'fil_mri_organise_batch'

%% SUBJECT DETAILS
% subject 1: 01RoYi
subj{1} = struct(...
                'scanid', 'MP02313',...
                'localiser',  1,...
                'structural', 2,...
                'functional', 6:10,...
                'fieldmaps', [4 5]);

% subject 2: 02XiHo
subj{2} = struct(...
                'scanid', 'MP02313',...
                'localiser',  1,...
                'structural', 2,...
                'functional', 6:10,...
                'fieldmaps', [4 5]);
            
% subject 3: 03JaVe
subj{3} = struct(...
                'scanid', 'MP02319',...
                'localiser',  1,...
                'structural', 2,...
                'functional', 6:11,...
                'fieldmaps', [4 5]);

% subject 4: 04NiSi
subj{4} = struct(...
                'scanid', 'MP02320',...
                'localiser',  1,...
                'structural', 2,...
                'functional', [6 7 9 10 11],...
                'fieldmaps', [4 5]);

%% Save details
save('subject_details.mat','subj');
% save('../analysis/subject_details.mat','subj');