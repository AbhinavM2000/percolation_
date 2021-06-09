All attachments and images should be in the same folder.

testim.m is the main file, it contains detailed comments.

Code includes the following major updates
- uses weighted average of r,g,b layers' graythresh thresholds before binarizing image, so now, no colour is neglected
- finds the exact r,g,b colour threshold (from average graythresh) above/below which image is binarized 
- function to compute distance between center of two clusters added
- function to compute minimum distance between two clusters added
