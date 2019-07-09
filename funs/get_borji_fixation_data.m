%Function to aggregate and write out the fixation data from the Borji
%experiment

function borji_data_table = get_borji_fixation_data(path_to_borji_data)

if exist(path_to_borji_data,'dir') == 7
    borji_data_files = dir(fullfile(path_to_borji_data,'*.mat'));
    borji_data_table = [];
    for each_file = 1:length(borji_data_files)
        full_file_path = strcat(path_to_borji_data,borji_data_files(each_file).name);
        if exist(full_file_path,'file') == 2
            file_data = load(full_file_path);
            for each_trial = 1:length(eyeSaccade);
                this_trial_data = eyeSaccade{each_trial,1};
                borji_data_table = [borji_data_table;this_trial_data];
            end
            
        end
    end
    

    
end