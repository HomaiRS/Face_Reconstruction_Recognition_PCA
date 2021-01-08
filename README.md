# MIT face recognition project dataset
In this project, the dataset from “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) was used for classifying face images using different machine learning algorithms including. The dataset contains face images from different age, race and sex groups makes the classification task more challenging. Also, cumulatively, there are about 400 infant, face aside, too dark, too bright, and blank images in the dataset. Therefore, these images should either be preprocessed or excluded before the classification analysis. 

# Dimentionality reduction
All the images are first vectorized to a 16384 × 1 vectors and concatenated in a matrix. We used Principle Component Analysis (PCA) based on the added reference in the following table to reduce the dimention (16384 × 16384) of the covariance matrix of the slacked matrix of images to a m × m matrix where m is the total number of images (e.g, 16 × 16). 

FaceRecognition_PCA
