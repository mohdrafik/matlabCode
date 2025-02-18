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

% Loop through each .csv file
GPU=input('\nEnter 1 for running in GPU, and 0 for running in CPU:');

for file_idx = 1:length(csv_files)
    
    % Get full file path
    csv_file = fullfile(input_dir, csv_files(file_idx).name);
    
    % Extract file name without extension (e.g., sphere, rod, ellipsoid)
    [~, filename, ~] = fileparts(csv_file);
    filename_parts = strsplit(filename,'_');  % Split by _ (underscore)  --> Converts parameter_combinations_ellipsoid → {"parameter", "combinations", "ellipsoid"}.
    filenameforshape = filename_parts{end};   % filename for shape.

    fprintf("extracted filename : %s and fileshape: %s\n",filename,filenameforshape);
%     pause;

    % Read CSV file into a table
    data_table = readtable(csv_file);

        %   by default all sphere csv file parameter is taken which have common name.
        r_eff_current_file = data_table.r_eff;             % Numeric
        nb_current_file = data_table.nb;                   % Numeric
        d_current_file = data_table.voxel_size;            % Numeric
        light_x_current_file = data_table.light_x;         % Numeric
        light_y_current_file = data_table.light_y;         % Numeric
        light_z_current_file = data_table.light_z;         % Numeric

    if filenameforshape == "sphere" 
        fprintf(" sphere shape is matched:\n");
        % Ensure correct data types by extracting columns separately
%         r_eff_sph = data_table.r_eff;             % Numeric
%         nb_sph = data_table.nb;                   % Numeric
%         d_sph = data_table.voxel_size;            % Numeric
%         light_x_sph = data_table.light_x;         % Numeric
%         light_y_sph = data_table.light_y;         % Numeric
%         light_z_sph = data_table.light_z;         % Numeric
        %         pol_x = data_table.pol_x;             % Numeric
        %         pol_y = data_table.pol_y;             % Numeric
        %         pol_z = data_table.pol_z;             % Numeric
        %         Meshing = data_table.Meshing;         % Numeric
        %         IB = data_table.Incident_Beam;        % **String Data**

    elseif filenameforshape == "rod"
          fprintf(" rod shape is matched:\n");
%         r_eff_rod = data_table.r_eff;             % Numeric
%         nb_rod = data_table.nb;                   % Numeric
%         d_rod = data_table.voxel_size;            % Numeric
%         light_x_rod = data_table.light_x;         % Numeric
%         light_y_rod = data_table.light_y;         % Numeric
%         light_z_rod = data_table.light_z;         % Numeric
        aspect_ratio_rod = data_table.aspect_ratio;  % Numeric

    elseif filenameforshape == "ellipsoid"
         fprintf(" ellipsoid shape is matched:\n");
%         r_eff_ellips = data_table.r_eff;             % Numeric
%         nb_ellips = data_table.nb;                   % Numeric
%         d_ellips = data_table.voxel_size;            % Numeric
%         light_x_ellips = data_table.light_x;         % Numeric
%         light_y_ellips = data_table.light_y;         % Numeric
%         light_z_ellips = data_table.light_z;         % Numeric
        ratio_y_xsemi_ellips = data_table.ratio_y_x;  % Numeric
        ratio_z_xsemi_ellips = data_table.ratio_z_x;  % Numeric
        
    else
        fprintf("No shape is matched:\n");
    end
    

% fixed parameters(GPU,nb,r_eff,d,Np_shape,Structure,E01,K01,Np_name,Meshing,IB,AR,ARyx,ARzx) 
% feeded to the function Absorption_Spectra.m, Fixed parameters (common for all shapes)
% GPU already given.
E01 = [0, 0, 1];  % polarization_directions = [0, 0, 1]; % always Fixed
Structure = "monomeric";
Np_name = "Au";  %material = "Au";
Meshing = 1;
IB = "plane wave"; % incident_beam = 'plane wave';
    
    % Loop through each row in the table
    for row_idx = 1:height(data_table)
        % Extract values from the table row
        r_eff = r_eff_current_file(row_idx); % effective r
        nb = nb_current_file(row_idx); % refractive index
        d = d_current_file(row_idx); % voxel size
        K01 = [light_x_current_file(row_idx), light_y_current_file(row_idx), light_z_current_file(row_idx)];
        % E01 = [pol_x(row_idx), pol_y(row_idx), pol_z(row_idx)];
        % Np_name = 'Au'; % Fixed material
        Np_shape = filenameforshape; % Extract shape from filename
        % Structure = 'monomeric'; % Fixed structure
        % IB_val = IB{row_idx}; % **Extract string from cell**



        if Np_shape == "sphere"
            ARyx = 0;
            ARzx = 0;
            AR = 0;
            
        elseif Np_shape == "rod"
                ARyx = 0;
                ARzx = 0;
                AR = aspect_ratio_rod(row_idx);
        elseif Np_shape == "ellipsoid"
                ARyx = ratio_y_xsemi_ellips(row_idx);
                ARzx = ratio_z_xsemi_ellips(row_idx);
                AR = 0;

        else
            fprintf("no shape is matched:\n");
        end
       
        % Debug: Display extracted parameters
        fprintf('\nProcessing Row %d/%d in %s\n', row_idx, height(data_table), filenameforshape);
        fprintf('r_eff = %.2f, nb = %.4f, d = %.4f, Shape = %s, Incident_Beam = %s\n', ...
                r_eff, nb, d, Np_shape, IB);

        % Run the Absorption_Spectra script
        % Absorption_Spectra(GPU,nb,r_eff,d,Np_shape,Structure,E01,K01,Np_name,Meshing,IB,AR,ARyx,ARzx);
[d, N, r_eff, t0_initial, Total_Time, Time_each, Wavelength, Q_EXT, Q_ABS, Q_SCAT] = Absorption_Spectra(GPU,nb,r_eff,d,Np_shape,Structure,E01,K01,Np_name,Meshing,IB,AR,ARyx,ARzx);

        % Save the result in the output directory and Save all outputs to a .mat file 
      
        result_filename = sprintf('%s_result_row_%d.mat', filenameforshape, row_idx);
        save(fullfile(output_dir, result_filename), 'd', 'N', 'r_eff', 't0_initial', 'Total_Time', 'Time_each', 'Wavelength', 'Q_EXT', 'Q_ABS', 'Q_SCAT');
        disp('Results saved to absorption_results.mat');

%% <--------- Save Results as a CSV (for tabular data) --------------> see .m file(saveresultCSV.m) where code is written for this csv in future .
%         % Convert to table (assuming Wavelength & Q values are vectors)
%         T = table(Wavelength, Q_EXT, Q_ABS, Q_SCAT);
%         % Save table to CSV
%         writetable(T, 'absorption_spectra.csv');
%         disp('Spectra results saved to absorption_spectra.csv');


    end
%     clc;
%     clear ;
  close;
end

fprintf('\nAll CSV files processed successfully. Results saved in %s\n', output_dir);




    % Summary ------------------------------------------------------------------
    % x = input('Enter a number: ') → Numeric (double), MATLAB evaluates input.
    % x = input('Enter a text: ', 's') → String (char), MATLAB stores as text.
    % Use 's' for string input to avoid MATLAB trying to evaluate it.
    % Use str2double(input('Enter a number: ', 's')) when expecting numeric input as a string.




%%%%%%%%%%%%%%%%---------------- %%%%%%
    
%     % Loop through each row of the CSV file
%     for row_idx = 1:size(data_array, 1)
%         
%         % Extract parameters from the row (assuming the CSV has correct columns)
%         r_eff = data_array(row_idx, 1);  % Effective radius
%         nb = data_array(row_idx, 2);     % Refractive index
%         d = r_eff / 33.333;              % Compute voxel size based on optimized ratio
%         E01 = [0, 0, 1];                 % Fixed polarization direction
%         K01 = [1, 0, 0];                 % Fixed propagation direction
%         Np_name = 'Au';                  % Fixed material
%         Np_shape = filename;             % Extract shape from filename
%         Structure = 'monomeric';         % Fixed structure
%         IB = 'plane wave';               % Fixed incident beam
%         Meshing = 1;                     % Standard meshing
%         
%         % Display parameters in the console for debugging
%         fprintf('\nProcessing File: %s, Row: %d\n', csv_files(file_idx).name, row_idx);
%         fprintf('r_eff = %.2f, nb = %.4f, d = %.4f, Shape = %s\n', r_eff, nb, d, Np_shape);
%         
% % Summary ------------------------------------------------------------------
% % x = input('Enter a number: ') → Numeric (double), MATLAB evaluates input.
% % x = input('Enter a text: ', 's') → String (char), MATLAB stores as text.
% % Use 's' for string input to avoid MATLAB trying to evaluate it.
% % Use str2double(input('Enter a number: ', 's')) when expecting numeric input as a string.
% % --------------------------------------------------------------------------
% 
%         % Run the Absorption_Spectra script
%         Absorption_Spectra;
% 
%         % Save the result in the output directory
%         result_filename = sprintf('%s_result_row_%d.mat', filename, row_idx);
%         save(fullfile(output_dir, result_filename), 'Q_EXT', 'Q_ABS', 'Q_SCAT');
%         
%     end
% 
% end
% 
% fprintf('\nAll CSV files processed successfully. Results saved in %s\n', output_dir);
