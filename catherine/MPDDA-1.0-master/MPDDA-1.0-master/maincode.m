clc;
clear all;

% Define input and check the files are already generated or not, better
% generate these input files using the python script first , faster
input_dir = 'E:\teaching  urban pro_superprof\matproject_cath\catherine\MPDDA-1.0-master\MPDDA-1.0-master\matcombfile';

csv_files = dir(fullfile(input_dir, '*.csv'));
csv_files = csv_files(~[csv_files.isdir]); 
% Display the CSV files
disp("CSV files:");
disp({csv_files.name});

% If the number of CSV files is not exactly 3, call 'generateinput.m'
if length(csv_files) ~= 3
    if exist('generateinput.m', 'file')
        generateinput;
    else
        error('Function "generateinput" not found. Please check its path.');
    end
end



% Define input and output directories
output_dir = 'E:\teaching  urban pro_superprof\matproject_cath\catherine\MPDDA-1.0-master\MPDDA-1.0-master\output';

% Ensure output directory exists
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Get a list of all .csv files in the directory
% csv_files = dir(fullfile(input_dir, '*.csv'));

% Loop through each .csv file
for file_idx = 1:length(csv_files)
    
    % Get full file path
    csv_file = fullfile(input_dir, csv_files(file_idx).name);
    
    % Extract file name without extension (e.g., sphere, rod, ellipsoid)
    [~, filename, ~] = fileparts(csv_file);
    
    fprintf("extracted filename :  %s\n",filename);
    % Read CSV file into a table
    data_table = readtable(csv_file);
    
    % Convert table to an array for easier row-wise access
    data_array = table2array(data_table);
    
    % Loop through each row of the CSV file
    for row_idx = 1:size(data_array, 1)
        
        % Extract parameters from the row (assuming the CSV has correct columns)
        r_eff = data_array(row_idx, 1);  % Effective radius
        nb = data_array(row_idx, 2);     % Refractive index
        d = r_eff / 33.333;              % Compute voxel size based on optimized ratio
        E01 = [0, 0, 1];                 % Fixed polarization direction
        K01 = [1, 0, 0];                 % Fixed propagation direction
        Np_name = 'Au';                  % Fixed material
        Np_shape = filename;             % Extract shape from filename
        Structure = 'monomeric';         % Fixed structure
        IB = 'plane wave';               % Fixed incident beam
        Meshing = 1;                     % Standard meshing
        
        % Display parameters in the console for debugging
        fprintf('\nProcessing File: %s, Row: %d\n', csv_files(file_idx).name, row_idx);
        fprintf('r_eff = %.2f, nb = %.4f, d = %.4f, Shape = %s\n', r_eff, nb, d, Np_shape);
        
% Summary ------------------------------------------------------------------
% x = input('Enter a number: ') → Numeric (double), MATLAB evaluates input.
% x = input('Enter a text: ', 's') → String (char), MATLAB stores as text.
% Use 's' for string input to avoid MATLAB trying to evaluate it.
% Use str2double(input('Enter a number: ', 's')) when expecting numeric input as a string.
% --------------------------------------------------------------------------

        % Run the Absorption_Spectra script
        Absorption_Spectra;

        % Save the result in the output directory
        result_filename = sprintf('%s_result_row_%d.mat', filename, row_idx);
        save(fullfile(output_dir, result_filename), 'Q_EXT', 'Q_ABS', 'Q_SCAT');
        
    end

end

fprintf('\nAll CSV files processed successfully. Results saved in %s\n', output_dir);
