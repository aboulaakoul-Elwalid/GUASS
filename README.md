# Image Fusion Using Gaussian Elimination and Gaussian Filter in MATLAB

This repository showcases a MATLAB-based approach for **image fusion** using a combination of **Gaussian elimination** and **Gaussian filtering**. This method allows merging two images by enhancing features from each through a blend of linear algebra techniques and image smoothing.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Results](#results)
- [Future Improvements](#future-improvements)
- [License](#license)

---

## Overview

Image fusion combines the relevant information from two images into a single composite image. This project uses **Gaussian elimination** to handle the blending and **Gaussian filters** to smooth out the image, reducing noise and enhancing details.

### Key Methods
1. **Gaussian Elimination**: Used for blending pixel values of the two images by solving systems of linear equations.
2. **Gaussian Filter**: Applied to smooth the final composite image, improving the visual quality by reducing high-frequency noise.

---

## Features

- Fuses two images by combining linear algebra and image processing techniques.
- Applies Gaussian filtering to enhance the clarity and smoothness of the fused image.
- Suitable for both grayscale and color images.

---

## Requirements

- **MATLAB** (recommended version R2021a or newer for optimal compatibility)
- Image Processing Toolbox (for Gaussian filtering)

---

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/aboulaakoul-Elwalid/GUASS
   cd gaussian-elimination-image-fusion
   ```

2. **Prepare Your Images**:
   - Place the two images you want to fuse in the project folder, or specify their paths in the MATLAB script.

3. **Run the MATLAB Script**:
   - Open MATLAB, navigate to the project folder, and run the main script:
     ```matlab
     fuse_images('image1.jpg', 'image2.jpg');
     ```

---

## Usage

The primary function `fuse_images` in this repository takes two input images and performs fusion using Gaussian elimination and a Gaussian filter.

```matlab
function fused_image = fuse_images(image1_path, image2_path)
    % Load images
    img1 = imread(infrared);
    img2 = imread(image);

    % Perform Gaussian elimination for blending
    % (Implementation here for matrix blending)

    % Apply Gaussian filter to smooth the fused image
    % (Gaussian filter code here)

    % Display result
    imshow(fused_image);
end
```

### Parameters

- **image1_path**: Path to the first image file.
- **image2_path**: Path to the second image file.

---

## Results

Example of fused images:

- **Input Image 1**: 
- **Input Image 2**: 
- **Fused Image** (with Gaussian elimination and Gaussian filtering):

*(Add sample images here for reference)*

---

## Future Improvements

- Experiment with different kernel sizes for the Gaussian filter to improve noise reduction.
- Explore alternative fusion techniques such as wavelet transforms for richer feature extraction.

---

## License

This project is licensed under the MIT License.
