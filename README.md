# Retinal-Vessel-Segmentation

## Preprocessing:
* Extract mask image
* Extract green channel
* CLAHE contrast enhancement  
<p align=center>
<img src="https://github.com/farkoo/Retinal-Vessel-Segmentation/blob/master/Figure1.png">
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

