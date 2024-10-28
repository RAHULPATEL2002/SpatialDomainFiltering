## LAB:05 Spatial Domain Filtering Based Restoration (UI22EC58)
MATLAB code for LAB 05 in the UI22EC58 course, focused on spatial domain filtering to restore degraded images. This project covers generating degraded images by adding Gaussian, Salt, Pepper, and Salt & Pepper noise and then applying various spatial filter operations to restore the image quality.

## Table of Contents
Project Overview
Features
Noise Types Covered
Filter Operations for Restoration
MATLAB Code Structure
Usage
Example Output
Contributing
# Project Overview
This project is part of LAB 05 for the course UI22EC58. The objective is to understand the effects of different noise types on an image and learn various spatial filtering techniques for image restoration. The MATLAB code demonstrates the degradation process by adding noise and restores the images using several filters.

## *** Features *** 
Add Gaussian, Salt, Pepper, and Salt & Pepper noise to an image.
Apply various spatial filters to restore degraded images.
Visualize the impact of each filtering technique on different types of noise.

### Noise Types Covered
Gaussian Noise - Randomly varies the pixel values, simulating natural variations.
Salt Noise - Randomly sets pixels to white (bright noise).
Pepper Noise - Randomly sets pixels to black (dark noise).
Salt & Pepper Noise - Randomly sets pixels to either black or white.
Filter Operations for Restoration

## This project includes the following filtering techniques:

Arithmetic Mean Filter - Smooths the image by averaging neighboring pixels.
Geometric Mean Filter - Reduces Gaussian noise while preserving details.
Harmonic Mean Filter - Reduces impulsive noise, such as Salt & Pepper noise.
Contra-Harmonic Mean Filter - Useful for removing salt or pepper noise depending on the parameter value.
Median Filter - Efficient for Salt & Pepper noise removal.
Min Filter - Useful for reducing the effect of pepper noise.
Max Filter - Useful for reducing the effect of salt noise.
Mid-Point Filter - Averages the min and max pixel values, suitable for random noise.

## MATLAB Code Structure
The MATLAB script is organized into two main sections:

Noise Generation - Adds various types of noise to an original grayscale image.
Filtering Operations - Applies different spatial filters to restore each noisy image.

## Usage
Clone this repository:
bash
Copy code
git clone https://github.com/RAHULPATEL2002/SpatialDomainFiltering.git

Open the MATLAB script LAB05_UI22EC58.m in your MATLAB environment.
Run the script to generate and visualize the degraded and restored images.
## Example Output
Below are some example outputs from running the MATLAB code:

Noisy Images
Original Image:
![image](https://github.com/user-attachments/assets/7dfbcff8-de62-4fda-8d85-2e546d8678c4)


Gaussian Noise:Salt Noise:Pepper Noise:Salt & Pepper Noise:
![image](https://github.com/user-attachments/assets/0a86d785-bd67-4a6e-ba75-9e2b64fb7cea)


Restored Images (Example Filters)
 (Gaussian Noise):
![image](https://github.com/user-attachments/assets/df2af89d-4ec0-4c8c-9e0b-46bd422e3d0f)
![image](https://github.com/user-attachments/assets/a42d7d97-d827-49d0-99e2-991803834998)

(salt noise):
![image](https://github.com/user-attachments/assets/6e41e636-b05b-428e-ae68-b1b8d377ad3a)
![image](https://github.com/user-attachments/assets/330ecb26-a345-499b-992a-3932733bbd95)

(Pepper Noise):
![image](https://github.com/user-attachments/assets/2a798a20-e0c0-4127-ae1b-ae4d39e92747)
![image](https://github.com/user-attachments/assets/6b990e89-1a5b-42cc-beed-21146a92a81f)

(Salt & Pepper Noise):
![image](https://github.com/user-attachments/assets/9e4f772b-b8af-4031-b34e-e8e9a49fd6b3)
![image](https://github.com/user-attachments/assets/51d9fc53-8535-42d7-81b3-98fca416a9e3)



(Additional outputs can be added here for each noise and filter combination.)

Contributing
Contributions are welcome! If you have ideas for additional filter types or enhancements, feel free to open an issue or submit a pull request.
