# MIT face recognition project dataset
The “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) dataset was used for classifying face images using different machine learning algorithms.

# General eigenface procedure
We randomly selected 40 children face images from the dataset and shown them in the following figure. Next, we used Principal Component Analysis (PCA) for dimentionality reduction, and summarizing the correlations among a set of observed variables with a smaller set of linear combinations. In order to capture the variance in the set of variables for face recognition, we computed the covariance matrix of the data containing vectorized images in each column (Γ1, ..., Γ2).

![Childrendata](https://user-images.githubusercontent.com/43753085/104047465-4ee5bf80-51a7-11eb-8372-9b6b14363cdd.png)

Since all faces are natural human faces, they all have common features such as eyes, nose, mouth, etc. that appeare in the average face (Ψ). The average face is shown in the following figure. Then the average face vector is subtracted from each image in the data (Φ = φ1, ..., φn, φi = Γ − Ψ). 

![averageface](https://user-images.githubusercontent.com/43753085/104048518-f1eb0900-51a8-11eb-9ac7-b8bba5572104.png)

The covariance matrix of data (Φ), then, is computed by (1/M ∑mi=1 φit(φi)) . C which is an n×n matrix. The PCA (SVD) is applied on this covariance matrix C([U, S, V ] = SV D(C)). The columns of V matrix are bases of eigenspace. The top eight dominant eigenvectors (eigenfaces) of are shown in figure 5.



