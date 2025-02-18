import itertools
import pandas as pd
import os

# Fixed parameters always constant for all shapes
polarization_directions = [(0, 0, 1)]  # fixed for all 
structure = 'monomeric'
material = 'Au'
meshing = 1
incident_beam = 'plane wave'
tolerance = 0.333
optimum_ratio = 33.333

# common parameters for all shapes
refractive_indices = [1.3617, 1.372, 1.383, 1.3940, 1.4049, 1.41590, 1.4270, 1.4381, 1.4494, 1.4607, 1.4722]

shapes = ['spherical','rod','ellipsoid']
# Define parameter values
# light_directions = [(0, 0, 0), (0.1, 0.1, 0.1), (0.2, 0.2, 0.2), (0.3, 0.3, 0.3), (0.4, 0.4, 0.4), (0.5, 0.5, 0.5), (0.6, 0.6, 0.6), (0.7, 0.7, 0.7),(0.8, 0.8, 0.8), (0.9, 0.9, 0.9), (1, 1, 1)]
light_directions = [
    (0, 0, 0), (0.1, 0.1, 0.1), (0.2, 0.2, 0.2), (0.3, 0.3, 0.3), 
    (0.4, 0.4, 0.4), (0.5, 0.5, 0.5), (0.6, 0.6, 0.6), (0.7, 0.7, 0.7),
    (0.8, 0.8, 0.8), (0.9, 0.9, 0.9), (1, 1, 1)
]



# Define variable parameters
refractive_indices = [1.3617, 1.372, 1.383, 1.3940, 1.4049, 1.41590, 1.4270, 1.4381, 1.4494, 1.4607, 1.4722]
shapes = ['spherical', 'rod', 'ellipsoid']
light_directions = [
    (0, 0, 0), (0.1, 0.1, 0.1), (0.2, 0.2, 0.2), (0.3, 0.3, 0.3), 
    (0.4, 0.4, 0.4), (0.5, 0.5, 0.5), (0.6, 0.6, 0.6), (0.7, 0.7, 0.7),
    (0.8, 0.8, 0.8), (0.9, 0.9, 0.9), (1, 1, 1)
]

# spherical radius and corresponding voxel sizes
spherical_radii = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60]
voxel_sizes = [0.3, 0.45, 0.6, 0.75, 0.9, 1.05, 1.2, 1.35, 1.5, 1.65, 1.8]

# Generate valid combinations with restrictions
valid_combinations = []
for shape in shapes:
    if shape == "spherical":
        print(f"\n --> I am in the spherical shape")       
        for r_eff, voxel_size in zip(spherical_radii, voxel_sizes):
            for nb in refractive_indices:
                for light_dir in light_directions:
                    for pol_dir in polarization_directions:
                        ratio = r_eff / voxel_size
                        valid_combinations.append({
                            'r_eff': r_eff,
                            'nb': nb,
                            'voxel_size': voxel_size,
                            'ratio (r_eff/voxel_size)': ratio,
                            'light_direction': light_dir,
                            'polarization_direction': pol_dir,
                            'Np_shape': shape,
                            'Structure': structure,
                            'Np_name': material,
                            'Meshing': meshing,
                            'Incident_Beam': incident_beam
                        })

    # Convert to DataFrame
        df_combinations = pd.DataFrame(valid_combinations)

        # Save the DataFrame to a CSV file
        output_file_path = r"E:\teaching  urban pro_superprof\matproject_cath\data\processed"
        output_file_name = f"parameter_combinations_{shape}.csv"
        output_file_path1 = os.path.join(output_file_path,output_file_name)
        # df_combination
        df_combinations.to_csv(output_file_path1, index=False)
        print(f"\n combination for the spherical is finished ..!and output_file: {output_file_name}\n")

        #  <........... combination for the spherical is finished .............> 


# voxel_sizes = [0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1, 1.125, 1.25, 1.375, 1.5] # for rods
    voxel_sizes = [0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1, 1.125] # for rods
    aspect_ratios = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5]
    radius_effective_rod = [10, 15, 20, 25, 30, 35, 40, 45]
    valid_combinations = []
    if shape == "rod":
        print(f"\n --> I am in the rod shape")       
        for r_eff, voxel_size in zip(radius_effective_rod, voxel_sizes):
            for nb in refractive_indices:
                for ar in aspect_ratios:  # Include aspect ratio for rods
                    for light_dir in light_directions:
                        for pol_dir in polarization_directions:
                            ratio = r_eff / voxel_size
                            valid_combinations.append({
                                'r_eff': r_eff,
                                'nb': nb,
                                'voxel_size': voxel_size,
                                'ratio (r_eff/voxel_size)': ratio,
                                'aspect_ratio': ar,
                                'light_direction': light_dir,
                                'polarization_direction': pol_dir,
                                'Np_shape': shape,
                                'Structure': structure,
                                'Np_name': material,
                                'Meshing': meshing,
                                'Incident_Beam': incident_beam
                            })

    # Convert to DataFrame
        df_combinations = pd.DataFrame(valid_combinations)
            # Save the DataFrame to a CSV file formatted for MATLAB
        output_file_path = r"E:\teaching  urban pro_superprof\matproject_cath\data\processed"
        output_file_name = f"parameter_combinations_{shape}.csv"
        output_file_path1 = os.path.join(output_file_path,output_file_name)
        # df_combination
        df_combinations.to_csv(output_file_path1, index=False)
        print(f"\n combination for the rod is finished ..!and output_file: {output_file_name}\n")

        #  <........... combination for the rod is finished .............> 

    
    radius_effective_ellipsoid = [10, 15, 20, 25, 30, 35, 40, 45]
    ratio_y_x = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5]  # Ratio of y-semi axis to x-semi axis
    ratio_z_x = [3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5]  # Ratio of z-semi axis to x-semi axis:
    voxel_sizes = [0.3, 0.45, 0.6, 0.75, 0.9, 1.05, 1.2, 1.35]
    valid_combinations = []

    if shape == "ellipsoid":       
        print(f"\n --> I am in the ellipsoid shape \n")       
        for r_eff, voxel_size in zip(radius_effective_ellipsoid, voxel_sizes):
            for nb in refractive_indices:
                for y_x_ratio in ratio_y_x:
                    for z_x_ratio in ratio_z_x:
                        for light_dir in light_directions:
                            for pol_dir in polarization_directions:
                                ratio = r_eff / voxel_size
                                valid_combinations.append({
                                    'r_eff': r_eff,
                                    'nb': nb,
                                    'voxel_size': voxel_size,
                                    'ratio (r_eff/voxel_size)': ratio,
                                    'ratio_y_x': y_x_ratio,
                                    'ratio_z_x': z_x_ratio,
                                    'light_direction': light_dir,
                                    'polarization_direction': pol_dir,
                                    'Np_shape': 'ellipsoid',
                                    'Structure': structure,
                                    'Np_name': material,
                                    'Meshing': meshing,
                                    'Incident_Beam': incident_beam
                                })


            # Convert to DataFrame for better visualization
        df_combinations = pd.DataFrame(valid_combinations)
        # Save the DataFrame to a CSV file formatted for MATLAB
        output_file_path = r"E:\teaching  urban pro_superprof\matproject_cath\data\processed"
        output_file_name = f"parameter_combinations_{shape}.csv"
        output_file_path1 = os.path.join(output_file_path,output_file_name)
        # df_combination
        df_combinations.to_csv(output_file_path1, index=False)
        print(f"\n combination for the ellipsoid is finished ..!and output_file: {output_file_name} \n")


"""
light_directions = [
    (0, 0, 0), (0, 0, 0.1), (0, 0, 0.2), (0, 0, 0.3), (0, 0, 0.4), (0, 0, 0.5), (0, 0, 0.6), (0, 0, 0.7), (0, 0, 0.8), (0, 0, 0.9), (0, 0, 1);
    (0, 0.1, 0), (0, 0.1, 0.1), (0, 0.1, 0.2), (0, 0.1, 0.3), (0, 0.1, 0.4), (0, 0.1, 0.5), (0, 0.1, 0.6), (0, 0.1, 0.7), (0, 0.1, 0.8), (0, 0.1, 0.9), (0, 0.1, 1);
    (0, 0.2, 0), (0, 0.2, 0.1), (0, 0.2, 0.2), (0, 0.2, 0.3), (0, 0.2, 0.4), (0, 0.2, 0.5), (0, 0.2, 0.6), (0, 0.2, 0.7), (0, 0.2, 0.8), (0, 0.2, 0.9), (0, 0.2, 1);
    (0, 0.3, 0), (0, 0.3, 0.1), (0, 0.3, 0.2), (0, 0.3, 0.3), (0, 0.3, 0.4), (0, 0.3, 0.5), (0, 0.3, 0.6), (0, 0.3, 0.7), (0, 0.3, 0.8), (0, 0.3, 0.9), (0, 0.3, 1);
    (0, 0.4, 0), (0, 0.4, 0.1), (0, 0.4, 0.2), (0, 0.4, 0.3), (0, 0.4, 0.4), (0, 0.4, 0.5), (0, 0.4, 0.6), (0, 0.4, 0.7), (0, 0.4, 0.8), (0, 0.4, 0.9), (0, 0.4, 1);
    (0, 0.5, 0), (0, 0.5, 0.1), (0, 0.5, 0.2), (0, 0.5, 0.3), (0, 0.5, 0.4), (0, 0.5, 0.5), (0, 0.5, 0.6), (0, 0.5, 0.7), (0, 0.5, 0.8), (0, 0.5, 0.9), (0, 0.5, 1);
    (0, 0.6, 0), (0, 0.6, 0.1), (0, 0.6, 0.2), (0, 0.6, 0.3), (0, 0.6, 0.4), (0, 0.6, 0.5), (0, 0.6, 0.6), (0, 0.6, 0.7), (0, 0.6, 0.8), (0, 0.6, 0.9), (0, 0.6, 1);
    (0, 0.7, 0), (0, 0.7, 0.1), (0, 0.7, 0.2), (0, 0.7, 0.3), (0, 0.7, 0.4), (0, 0.7, 0.5), (0, 0.7, 0.6), (0, 0.7, 0.7), (0, 0.7, 0.8), (0, 0.7, 0.9), (0, 0.7, 1);
    (0, 0.8, 0), (0, 0.8, 0.1), (0, 0.8, 0.2), (0, 0.8, 0.3), (0, 0.8, 0.4), (0, 0.8, 0.5), (0, 0.8, 0.6), (0, 0.8, 0.7), (0, 0.8, 0.8), (0, 0.8, 0.9), (0, 0.8, 1);
    (0, 0.9, 0), (0, 0.9, 0.1), (0, 0.9, 0.2), (0, 0.9, 0.3), (0, 0.9, 0.4), (0, 0.9, 0.5), (0, 0.9, 0.6), (0, 0.9, 0.7), (0, 0.9, 0.8), (0, 0.9, 0.9), (0, 0.9, 1);
    (0, 1, 0), (0, 1, 0.1), (0, 1, 0.2), (0, 1, 0.3), (0, 1, 0.4), (0, 1, 0.5), (0, 1, 0.6), (0, 1, 0.7), (0, 1, 0.8), (0, 1, 0.9), (0, 1, 1)
];

"""