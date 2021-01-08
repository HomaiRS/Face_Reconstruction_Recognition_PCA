# Dataset
This repository, contains two different datasets. 1) The “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) dataset, 2) my hand-picked celebrities images.

# Dimentionality reduction
All the images are first vectorized to a 16384 × 1 vectors and concatenated in a matrix. We used Principle Component Analysis (PCA) based on the added reference in the following table to reduce the dimention (16384 × 16384) of the covariance matrix of the slacked matrix of images to a m × m matrix where m is the total number of images (e.g, 16 × 16). 

# Image reconstruction
We used PCA for image reconstruction.

# Face recognition
We used two methods including KNN and PCA for face recognition. 
