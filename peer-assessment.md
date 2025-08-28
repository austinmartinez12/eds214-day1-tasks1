## Automate
### Running the entire analysis requires rendering one Quarto document
-meets. I can run the quarto doc and see the resulting figure.

### The analysis runs without errors
-meets. The quarto doc and data cleaning scripts do not show any errors.

### The analysis produces the expected output
-meets. The plot looks correct according to the ggplot code.

### Data import/cleaning is handled in its own script(s)
-meets. Data import and cleaning happens in its own script, and clean data is read into quarto doc.

## Organize
### Raw data is contained in its own folder
-meets. Raw data is stored in the "data" folder, as indicated in the README.

### Intermediate outputs are created and saved to a separate folder from raw data
-not yet. Clean data is kept in a subfolder of "data" called "cleaned_data". This folder could be moved to output, which would be more appropriate and avoid accidental changes to the raw data.

### At least one piece of functionality has been refactored into a function in its own file
-not yet. Clean data is done in a separate script, but the for loops for the moving average are done in the quarto doc. They could be made into a function in a separate R script in an "R" folder that is sourced into the quarto doc.

## Document
### The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs
-meets. I can find all locations for this content. The files aren't all necessarily where the README says they are, so I would adjust that so that the README is more accurate, or move the files!

### The README includes a flowchart and text explaining how the analysis works
-not yet. There is no flowchart yet!

### The code is appropriately commented
-not yet. Commenting is almost there, but the code for the moving average and ggplot could have more comments explaining what each part of the code is doing. This could go in a file if that code is in a separate file, so it can be longer and not on every single iteration of the analysis.

### Variable and function names are descriptive and follow a consistent naming convention
-not yet. Naming conventions switch between a few variations (Q1_column, Q1Janitor, clean_Q1). It could be simplified to site_whatever (Q1_column, Q1_janitor, Q1_clean) and be consistent with upper or lower case! the river_df could become river_combined to indicate its all 4 sites combined, river_long is good :)

## Scale
### Running the environment initialization script installs all required packages
-not yet. There is no environment initialization script with all the packages needed. That should be added to the root with a comment to use that to load the packages.