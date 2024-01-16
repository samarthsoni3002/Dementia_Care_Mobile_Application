import cv2
from skimage.feature import hog
import numpy as np

def extract_features(image):
    
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    hog_features, _ = hog(gray, orientations=8, pixels_per_cell=(4, 4), cells_per_block=(1, 1), visualize=True)
    hist_features = cv2.calcHist([image], [0, 1, 2], None, [8, 8, 8], [0, 256, 0, 256, 0, 256]).flatten()

    features = np.concatenate((hog_features, hist_features))
    
    return features