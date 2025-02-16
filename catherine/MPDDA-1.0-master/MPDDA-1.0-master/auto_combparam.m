%=========================================================================%
% Automated Parameter Sweep for Gold Nanoparticles in MATLAB %
%=========================================================================%

clear all;
clc;

% Define parameter values from the document
sphere_radii = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
refractive_indices = [1.3617, 1.372, 1.383, 1.3940, 1.4049, 1.41590, 1.4270, 1.4381, 1.4494, 1.4607, 1.4722];
voxel_sizes = [0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1, 1.125, 1.25, 1.375, 1.5];
light_directions = [0 0 1; 1 0 0; 0 1 0]; % Example light directions
polarization_directions = [0 0 1; 1 0 0; 0 1 0];  % Example polarization directions

% Define optimized ratios
% optimized_ratios.spherical = 33.333;
optimized_ratios.spherical = 30.333;
optimized_ratios.ellipsoid = 33.333;
optimized_ratios.rod = 40;
fprintf("\n I am in the autocombparam.m program: ")
% Fixed parameters
structure = 'monomeric';
material = 'Au';
meshing = 1; % Standard meshing
incident_beam = 'plane wave'; % Fixed plane wave

tolerance = 0.333;
optimum_ratio = optimized_ratios.spherical;

fprintf("tolerance %f and optimized ratio: %f \n ",tolerance,optimum_ratio)
% Loop through all parameter combinations
combination_idx = 1;
for r_eff = sphere_radii
    fprintf("\n I am in the autocombparam.m program: and entered in the first for loop r_eff\n")
    for nb = refractive_indices
        for voxel_size = voxel_sizes
            % Ensure the ratio conditions are met
            fprintf("\n BEFORE IF CONDITION >> optimized_ratios -- RATIO: ---> %0.5f and optimized_ratios.spherical  %0.5f:\n ",abs(r_eff / voxel_size),optimized_ratios.spherical);
%             if abs((r_eff / voxel_size) - optimized_ratios.spherical) >= 0
            if (r_eff / voxel_size) <= (optimum_ratio - tolerance)
                fprintf("\n AFTER IF CONDITION >>optimized_ratios -- RATIO: ---> %0.5f and optimized_ratios.spherical  %0.5f:\n ",abs(r_eff / voxel_size),optimized_ratios.spherical);
                for light_dir = light_directions'
                    for pol_dir = polarization_directions'
                        fprintf("combination process NO.-->: %d STARTED:\n", combination_idx)
                        % Assign parameters to workspace
                        r_eff = r_eff;
                        nb = nb;
                        d = voxel_size;
                        Np_shape = 'spherical';
                        Structure = structure;
                        Np_name = material;
                        E01 = pol_dir';
                        K01 = light_dir';
                        Meshing = meshing;
                        IB = incident_beam;

                        % Run the main MATLAB script
                        Absorption_Spectra;

                        % Save results with unique filenames
                        result_filename = sprintf('Result_Spectra_%d.mat', combination_idx);
                        save(result_filename, 'Q_EXT', 'Q_ABS', 'Q_SCAT');

                        fprintf("combination process no -->: %d FINISHED \n", combination_idx)

                        combination_idx = combination_idx + 1;
%                         fprintf(" combination_idx %d\n", combination_idx)         
                    end
                end
            end

        end
    end
end

fprintf('All simulations completed and results saved.\n');
