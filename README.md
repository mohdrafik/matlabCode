# **matlab_project1**  

## **Project Overview**  
This project automates the process of generating and processing parameter combinations for different shapes such as **Sphere, Rod, and Ellipsoid**. The workflow consists of two main steps:  

1. **Generating Parameter Combinations:**  
   - The first script creates **all possible combinations of parameters**.  
   - These combinations are **saved in CSV files** for different shapes (**Sphere, Rod, Ellipsoid, etc.**).  

2. **Processing the Generated Files:**  
   - Each **shape-specific CSV file** (e.g., `SPHERE.csv`) is read **row by row**.  
   - Each row is **fed as input** to the core script.  
   - The script **processes the input** and **saves the output** in `.csv` or `.mat` format in the **results folder**.  
   - This process is repeated for **other shape files** like `ROD.csv` and `ELLIPSOID.csv`.  

## **Workflow**  

```
Step 1: Generate all possible parameter combinations → Save to CSV files  
Step 2: Read CSV files row by row → Process with core script → Save results in .csv/.mat  
Step 3: Repeat for all shape types (Sphere, Rod, Ellipsoid, etc.)
```

## **Directory Structure**
```
matproject_chem1/
│── data/                   # Contains generated CSV files for different shapes
│── results/                # Stores processed output in .csv/.mat format
│── scripts/                # Core scripts for processing data
│── generateinput.m         # Script to create parameter combinations
│── maincode.m              # Core script that processes each row
│── README.md               # Project documentation
```

## **Usage**
1. Run **`generateinput.m`** to create parameter combinations.  
2. Run **`maincode.m`** to process the generated CSV files.  
3. Check the **results folder** for output files.  