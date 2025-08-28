# Automate

### [ ] Running the entire analysis requires rendering one Quarto document

-   Meets spec: All of my code runs without any errors. All of my outputs show up correctly

### [ ] The analysis runs without errors

-   Not yet: My analysis runs without errors in my pages quarto with all steps combined, but I haven't made my analysis its own script yet. Once I make my own script it will be checked out.

### [ ] The analysis produces the expected output

-   Meets spec: My code makes the expected output. I do want to change the titles on it though.
-   Exceeds spec: To exceed my spec I will display the chemical names along the side of my graphs instead of on top just like the original. I will also use the line type they use to differ between Q1,Q2,Q3,PRM.

### [ ] Data import/cleaning is handled in its own script(s)

-   Meets spec: My cleaning code is in its own script. It creates CSVs at the end that I read into my analysis script.

# Organize

### [ ] Raw data is contained in its own folder

-   Meets spec: My raw data isn't in its own folder its in the data folder. I will fix this and put it into a raw data folder.

### [ ] Intermediate outputs are created and saved to a separate folder from raw data

-   Meets spec: I did this in my data cleaning script. I made a cleaned CSV to use in analysis script

### [ ] At least one piece of functionality has been refactored into a function in its own file

-   Not yet: I have nothing refactored right now. I will implement this tonight for my rolling average and ggplot theme
-   Exceeds spec: To exceed my spec I will refactor 2 different things in my script. I will do my gglot theme and my rolling average function.

# Document

### [ ] The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs

-   Not yet: I have added new files and now my contents section isn't accurate. I need to go through and properly state where everything is.
-   Exceeds spec: To exceed my spec I will add links to the these 4 things in my readme.

### [ ] The README includes a flowchart and text explaining how the analysis works

-   Not yet: I still need to find a good place to make it. I also need to figure out exactly what to put in it.

### [ ] The code is appropriately commented

-   Not yet: There is some code I literally just added. I still need to go threw and correctly comment in it.

### [ ] Variable and function names are descriptive and follow a consistent naming convention

-   Meets spec: My file names are descriptive and have what i did as part of the name. My naming convention if consistent

# Scale

After cloning the repo on Workbench:

### [ ] Running the environment initialization script installs all required packages

-   Not yet: I am going to comment out the install.packages() for each package, so they just need to remove the \# to download it. I will also have a separate R script in my supporting code that will have this written out also.

### [ ] The analysis script runs without errors

-   Not yet: I haven't made this yet. I will make this and try it later.
