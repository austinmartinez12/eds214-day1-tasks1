# Exceeds spec

## [ ] The README includes a flowchart and text explaining how the analysis works
My flowchart and analysis are very polished. I made it on google slides and made sure it looked clean and easy to follow. My analysis description walks you threw exactly why I chose the exact function I used and the package I got it from. I even described the steps I did after running the function to prepare it for data visualization.


## [ ] At least one piece of functionality has been refactored into a function in its own file
I refactored my themes in my ggplot and added a function that makes loading in libraries easier. My function for my ggplot theme made my long code chunk a smaller more polished version. My function for loading in libraries will save future editors on this script or other scripts that use it time. They wont have to manually type library() for every single package they use. In addition I also added a roxygen skelleton to both functions that shows what the parameters are and what they stand for. I also provided examples of how it can be implemented into code.

# Collaboration

In 3-4 sentences, describe how your participation in peer feedback went. Give examples for how you were thorough and constructive.

My participation in the peer feed back was actually alot better than I thought it would be. I got alot of help from Leela when she peer reviewed my repo. she even added a vline and helped me change the title position on my plots. I was able to merge her edits into my code. I peer reviewed Jay's repo. Luckily I was able to be helpful to her. I made a separate script for her data cleaning and added the code to save the cleaned CSV to a folder in her repo, so she could use it in her analysis. She merged my edits!

Provide links to 3 closed issues that resulted from the self assessment and/or peer review.

-   <https://github.com/austinmartinez12/eds214-day1-tasks1/issues/16> I added my flow chart and explained how my analysis worked in my readme.

-   [https://github.com/austinmartinez12/eds214-day1-tasks1/issues/1](https://github.com/austinmartinez12/eds214-day1-tasks1/issues/15){.uri} I added this script (install.packages.R) it is in my supporting code.

-   <https://github.com/austinmartinez12/eds214-day1-tasks1/issues/11> I just did this cleaned_data that has cleaned data CSVs and my figure in a fig sub folder.

Provide a link to the commit on GitHub where you resolved a merge conflict.
https://github.com/austinmartinez12/eds214-day1-tasks1/commit/74a002f3730113a502af4de2b3f5e7c35d2e2a70

https://github.com/austinmartinez12/eds214-day1-tasks1/commit/963dcc8fb920feb5bbc19a61a68bf4b66aeca0fb

# Instructor feedback

## Automate

[M] **Running the entire analysis requires rendering one Quarto document**

[M] The analysis runs without errors

[M] **The analysis produces the expected output**
- Re-organize to match Fig. 3 in Schaefer et al. (2000)

[M] **Data import/cleaning is handled in its own script(s)**
- In the future, should modularize within `paper.qmd` and use `source()`

## Organize

[M] Raw data is contained in its own folder

[M] Intermediate outputs are created and saved to a separate folder from raw data

[E] **At least one piece of functionality has been refactored into a function in its own file**

## Document

[M] The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs

[E] **The README includes a flowchart and text explaining how the analysis works**

[M] **The code is appropriately commented**
- Remove "I" statements

[NY] **Variable and function names are descriptive and follow a consistent naming convention**
- Inconsitent case: `q2collumns` vs. `Rolling_mean_plot` vs. `hurricane_date`

## Scale

After cloning the repo on Workbench:

[M] Running the environment initialization script installs all required packages

[M] The analysis script runs without errors

## Collaborate

[M] **The student has provided attentive, constructive feedback in a peer review**

[M] **The student has contributed to a peer's repo by opening an issue and creating a pull request**

[M] The repo has at least three closed GitHub issues

[M] The commit history includes at least one merged branch and a resolved merge conflict

[M] The rendered analysis is accessible via GitHub Pages
