# Retinal-Vessel-Segmentation

The DRIVE database has been established to enable comparative studies on segmentation of blood vessels in retinal images. Retinal vessel segmentation and delineation of morphological attributes of retinal blood vessels, such as length, width, tortuosity, branching patterns and angles are utilized for the diagnosis, screening, treatment, and evaluation of various cardiovascular and ophthalmologic diseases such as diabetes, hypertension, arteriosclerosis and chorodial neovascularization.

In this repository i implement a system for segment blood vessel from DRIVE images.

# Steps

## Preprocessing:
* Extract mask image
* Extract green channel
* CLAHE contrast enhancement  
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/figure1.png">
</p>

* Replace black ring
* Top-hat transform

## Vessel Extraction
* Otsu thresholding
* Remove small regions
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/Figure2.png">
</p>

* Thick vessel extraction
* Thin vessel extraction
* Create the final image using the last two images
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/Figure3.png">
</p>

## Compare my result and ground truth
* Green: same ture in mr(my result) and gt(ground truth) 
* Red: one in mr and zero in gt
* Purple: Zero in mr and one in gt
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/Figure4.png">
</p>

# Final Results
My results for 20 test images:
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/Figure5.png">
</p>

