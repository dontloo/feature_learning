function file_names = dir2filenames (arg_dir)
    all_files = dir(arg_dir);
    file_names = cell(length(all_files)-2,1);
    for idx = 3:length(all_files)
%         file_names{idx-2} = all_files(idx).name;
        file_names{idx-2} = [arg_dir all_files(idx).name];
    end
end
