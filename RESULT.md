# Dataset
This repository, contains two different datasets. 1) The “MIT face recognition project” (http://courses.media.mit.edu/2004fall/mas622j/04.projects/faces/) dataset, 2) my hand-picked celebrities images.

# General eigenface procedure
We randomly selected 40 children face images from the dataset and shown them in the following figure. Next, we used Principal Component Analysis (PCA) for dimentionality reduction, and summarizing the correlations among a set of observed variables with a smaller set of linear combinations. In order to capture the variance in the set of variables for face recognition, we computed the covariance matrix of the data containing vectorized images in each column (Γ1, ..., Γ2).

![Childrendata](https://user-images.githubusercontent.com/43753085/104047465-4ee5bf80-51a7-11eb-8372-9b6b14363cdd.png)

Since all faces are natural human faces, they all have common features such as eyes, nose, mouth, etc. that appeare in the average face (Ψ). The average face is shown in the following figure. Then the average face vector is subtracted from each image in the data (Φ = φ1, ..., φn, φi = Γ − Ψ). 

![averageface](https://user-images.githubusercontent.com/43753085/104048518-f1eb0900-51a8-11eb-9ac7-b8bba5572104.png)

The covariance matrix of data (Φ), then, is computed by (1/M ∑mi=1 φit(φi)) . C which is an n×n matrix. The PCA (SVD) is applied on this covariance matrix C([U, S, V ] = SV D(C)). The columns of V matrix are bases of eigenspace. The top eight dominant eigenvectors (eigenfaces) of are shown in the following figure.

![EigSpace](https://user-images.githubusercontent.com/43753085/104048837-87869880-51a9-11eb-98e7-37639eb2e6ca.png)

# Computation reduction

Since each vectorized image is 16384 × 1 pixels, the covariance matrix of data is n × n as well. Thus, computing even first 20 dominant eigenvalues and eigenvectors of the C is time consuming. Thus, instead we use the formulation shown in the following figure to significantly expedite the computation time of the algorithm. This formulation reduces computation of eigenvectors/eigenvalues from computing 16384 × 16384 covariance matrix to computing eigenvectors/eigenvalues of 16 × 16 covariance matrix where 16 is the number of images in the dataset (m). Therefore, we used the lower dimention (16 × 16) covariance matrix to obtain the following results. In addition to dimentionality reduction formulation, in the following figure, the pattern of the covariance matrix, the singular value matrix, and the eigenfaces matrix are shown.

![reduction](https://user-images.githubusercontent.com/43753085/104049833-37103a80-51ab-11eb-91f7-8d2b90298e2a.png)

# Image reconstruction

We used the linear combination of eigenfaces to reconstruct the images in the dataset. Therefore, depending on the desire quality of reconstruction, we can use different rank approximations or number of eignevectors. Of course, as we use a larger number of eigenspace's basis (eigenfaces/eigenvectors) or as we use a larger rank for reconstruction, we have a lower reconstruction error. In the following figure, we showed the reconstruction results for two randomly selected faces from the dataset using 3, 7,11, and 15 eigenvectors, and we sould how the reconstruction error decreases as the number of eignenvectors increase.

![reconstruction](https://user-images.githubusercontent.com/43753085/104058584-92492980-51b9-11eb-9029-c21ec7ab7b83.png)

# Face recognition

We used KNN (K-nearest neighbors) for the face recognition. We first projected all images into the eigenspace and then we computed the Euclidean distance between the projection of the image in the testset with the projection of all images in the training set. The image with a smallest distance then will be recognized as the most similar face to the test image. In the folowing image, we showed the KNN results (with K=1) for face recognition.

![KNN](https://user-images.githubusercontent.com/43753085/104071170-363cd000-51ce-11eb-9e05-2b0734504bf7.png)

# Face recognition: repetitive images from same subject

So far, all results are based on the centered covariance matrix of the data. However, another approach used for face recognition is to not centering the train/test images by subtracting the average face from the images. We provided a dataset containing face images of six subjects in which each subject has six different images is collected. This dataset and the average face of each subject are shown in figure 18.







