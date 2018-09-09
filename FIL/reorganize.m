function [  ] = reorganize( old_path, new_path, remove_old)
%REORGNIZE(old_path, new_path, old_files, new_files)
%Used in fil_mri_organize by Steve Fleming & Dan Bang, FIL, 07/06/2016

if exist(old_path,'dir')==7;
    fname     = spm_select('List',old_path,'^s.*\.nii$');
    old_files = cellfun(@(path) fullfile(old_path,path),cellstr(fname),'UniformOutput',0);
    new_files = cellfun(@(path) fullfile(new_path,path),cellstr(fname),'UniformOutput',0);
    mkdir(new_path);
    for i = 1:size(old_files,1);
        copyfile(old_files{i},new_files{i});
    end;
    if remove_old
        rmdir(old_path,'s');
    end
end

end

