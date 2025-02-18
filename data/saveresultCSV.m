
for file_idx = 1:length(csv_files)
 % ---------

for row_idx = 1:height(data_table)



 %  ---------
 
 
 
 
 % -----------
 
 
 
	%% add this below written portion after the result of the function Absorption_Spectra.main
	
% Convert to table format
        temp_table = table(Wavelength, Q_EXT, Q_ABS, Q_SCAT);

        % Append results to the main results table
        results_table = [results_table; temp_table];  
    end
    
    % Define the output file name based on Np_shape
    output_filename = sprintf('absorption_spectra_%s.csv', Np_shape{1});
    
    % Save the results for this CSV file
    writetable(results_table, output_filename);
    
    fprintf('Results for %s saved as %s\n', csv_files{file_idx}, output_filename);
end