###README.md
=========
Author: Michael O'Flaherty (michael@oflaherty.com)

Create date: 6/18/2014

This read me file containts the steps needed to take in order to generate the data required for the Getting and Cleaning Data Course Project. The details of this assignment can be found here: [submission instructions](https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions).

Additional details about the source data can be found  [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and [here](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/).

A special shout-out goes to the course instructors who seeded this course project for me to run with:
* [Jeff Leek](http://biostat.jhsph.edu/~jleek/)
* [L. Collado-Torres](http://bit.ly/LColladoTorres)
* [Nick Reich](http://people.umass.edu/nick/)

Finally, it is recommended that you check out the file **CodeBook.md** included in this repository for details about the data itself. Happy analysis!

####How to Generate the Data
######Step 1
Place the script file **run_analysis.R** and the zip file **getdata_projectfiles_UCI HAR Dataset.zip** in the directory where you will want to process the data from. Unzip it so it creates a folder called getdata_projectfiles_UCI HAR Dataset. All of the data files needed for this script should exist here. (For details on how to unzip a file, click [how to unzip a file](http://www.ehow.com/how_7940327_unzip-file-windows.html).

######Step 2
Create a folder in the same folder called **data**.

######Step 3
Open the file **run_analysis.R** in your R environment (RStudio is recommended.) The first line of actual code (below the comments header) is the `setwd` function for setting the working folder. Replace the path defined there with the path where you have placed the script and zip file.

######Step 4
One package that was used in this script that needs loaded is called *data.table*. You can uncomment the line `#install.packages("data.table")` if you need to install it. R will pull it down from the internet, so you will need internet access.

######Step 4
Run the script. If there are no errors, a file called **tidyData.txt** will be created in the **data** folder.

######Step 5
If you want to read this data back into R, you can use this code: `tidyData <- read.table("data\\tidyData.txt")`.