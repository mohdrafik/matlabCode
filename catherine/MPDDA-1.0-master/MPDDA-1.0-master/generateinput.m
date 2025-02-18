
%==========================================================================
% Automated Parameter Combination Generation for Different Shapes
% Saves results in CSV files
%==========================================================================
clc
% clear all;
close all;


% "E:\teaching  urban pro_superprof\matproject_cath\data\processed\matcombfile"

% enter path like this with double quotes : "E:\teaching  urban pro_superprof\matproject_cath\data\processed\matcombfile"
path2saveData = input("enter the path to save the output combination csv files like as given: --->");
path2save_data = path2saveData;
if ~exist(path2save_data,'dir')
    mkdir(path2save_data);
end
fprintf("\n data path just to check if it created or not to save the final output file there: %s\n",path2save_data);


% Fixed parameters (common for all shapes)
polarization_directions = [0, 0, 1]; % Fixed
structure = 'monomeric';
material = 'Au';
meshing = 1;
incident_beam = 'plane wave';
tolerance = 0.333;
optimum_ratio = 33.333;

% Common parameters
refractive_indices = [1.3617, 1.372, 1.383, 1.3940, 1.4049, 1.41590, 1.4270, 1.4381, 1.4494, 1.4607, 1.4722];

% Define shapes
shapes = {'spherical', 'rod', 'ellipsoid'};

% Define light directions (same as Python)
light_directions = [
    0 0 0; 0.1 0.1 0.1; 0.2 0.2 0.2; 0.3 0.3 0.3;
    0.4 0.4 0.4; 0.5 0.5 0.5; 0.6 0.6 0.6; 0.7 0.7 0.7;
    0.8 0.8 0.8; 0.9 0.9 0.9; 1 1 1
];

% Define parameters for each shape
spherical_radii = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
voxel_sizes_spherical = [0.3, 0.45, 0.6, 0.75, 0.9, 1.05, 1.2, 1.35, 1.5, 1.65, 1.8];

radius_effective_rod = [10, 15, 20, 25, 30, 35, 40, 45];
voxel_sizes_rod = [0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1, 1.125];
aspect_ratios = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5];

radius_effective_ellipsoid = [10, 15, 20, 25, 30, 35, 40, 45];
voxel_sizes_ellipsoid = [0.3, 0.45, 0.6, 0.75, 0.9, 1.05, 1.2, 1.35];
ratio_y_x = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5];
ratio_z_x = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5];

%==========================================================================
% Generate and Save Parameter Combinations for Each Shape
%==========================================================================

for shape_idx = 1:length(shapes)
    shape = shapes{shape_idx};
    valid_combinations = [];

    fprintf("\nProcessing shape: %s\n", shape);
    
    % Generate combinations for Spheres
    if strcmp(shape, 'spherical')
        for i = 1:length(spherical_radii)
            r_eff = spherical_radii(i);
            voxel_size = voxel_sizes_spherical(i);
            ratio = r_eff / voxel_size;
            for nb = refractive_indices
                for light_dir = light_directions'
                    for pol_dir = polarization_directions'
                        valid_combinations = [valid_combinations; ...
                            r_eff, nb, voxel_size, ratio, num2cell(light_dir'), num2cell(pol_dir'), ...
                            meshing, incident_beam];
%                         fprintf("valid_combinations: --> ")
%                         disp(valid_combinations)
                    end
                end
            end
        end
        % Define column headers
%         headers = {'r_eff', 'nb', 'voxel_size', 'ratio_r_eff_voxel', ...
%                    'light_x', 'light_y', 'light_z', ...
%                    'pol_x', 'pol_y', 'pol_z', ...
%                    'Meshing', 'Incident_Beam'};
        headers = {'r_eff', 'nb', 'voxel_size', 'ratio_r_eff_voxel', ...
                   'light_x', 'light_y', 'light_z', ...
                   'pol_x', 'pol_y', 'pol_z', ...
                   'Meshing', 'Incident_Beam'};
    end

    % Generate combinations for Rods
    if strcmp(shape, 'rod')
        for i = 1:length(radius_effective_rod)
            r_eff = radius_effective_rod(i);
            voxel_size = voxel_sizes_rod(i);
            ratio = r_eff / voxel_size;
            for nb = refractive_indices
                for ar = aspect_ratios
                    for light_dir = light_directions'
                        for pol_dir = polarization_directions'
                            valid_combinations = [valid_combinations;r_eff, nb, voxel_size, ratio, ar, num2cell(light_dir'), num2cell(pol_dir'), meshing, incident_beam];
                        end
                    end
                end
            end
        end
        % Define column headers
        headers = {'r_eff', 'nb', 'voxel_size', 'ratio_r_eff_voxel', ...
                   'aspect_ratio', ...
                   'light_x', 'light_y', 'light_z', ...
                   'pol_x', 'pol_y', 'pol_z', ...
                   'Meshing', 'Incident_Beam'};
    end
    
    % Generate combinations for Ellipsoids
    if strcmp(shape, 'ellipsoid')
        for i = 1:length(radius_effective_ellipsoid)
            fprintf("process ongoing : %d/%d and process remaining: i/len(r_eff): %d/%d \n",i,length(radius_effective_ellipsoid), length(radius_effective_ellipsoid)-i,length(radius_effective_ellipsoid));
            r_eff = radius_effective_ellipsoid(i);
            voxel_size = voxel_sizes_ellipsoid(i);
            ratio = r_eff / voxel_size;
            for nb = refractive_indices
                for y_x = ratio_y_x
                    for z_x = ratio_z_x
                        for light_dir = light_directions'
                            for pol_dir = polarization_directions'
                                valid_combinations = [valid_combinations; ...
                                    r_eff, nb, voxel_size, ratio, y_x, z_x, num2cell(light_dir'), num2cell(pol_dir'), ...
                                    meshing, incident_beam];
                            end
                        end
                    end
                end
            end
        end
        % Define column headers
        headers = {'r_eff', 'nb', 'voxel_size', 'ratio_r_eff_voxel', ...
                   'ratio_y_x', 'ratio_z_x', ...
                   'light_x', 'light_y', 'light_z', ...
                   'pol_x', 'pol_y', 'pol_z', ...
                   'Meshing', 'Incident_Beam'};
    end

    %==========================================================================
    % Convert and Save the Results to CSV
    %==========================================================================

    % Convert numeric data to table
    if ~isempty(valid_combinations)
        valid_combinations_table = array2table(valid_combinations, 'VariableNames', headers);
        
        % Define output file name
%         path2save_data ="E:\teaching  urban pro_superprof\matproject_cath\data\processed\" ;
        
        output_filename = sprintf('parameter_combinationsmat_%s.csv', shape);
        full_filepath = fullfile(path2save_data, output_filename);
%         writetable(valid_combinations_table, output_filename);
        writetable(valid_combinations_table, full_filepath);

        fprintf("\nFinished processing shape: %s\nSaved output file: %s\n", shape, output_filename);
    else
        fprintf("\nNo valid combinations generated for shape: %s\n", shape);
    end
end

fprintf('\nAll parameter combinations generated and saved successfully.\n');
