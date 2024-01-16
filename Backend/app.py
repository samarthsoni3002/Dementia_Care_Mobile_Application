from flask import Flask, request, jsonify
import cv2
from skimage.feature import hog
import numpy as np
import pickle
from features import extract_features

app = Flask(__name__)

with open("./machine_learning_model_minor.pkl", "rb") as model_file:
    saved_model = pickle.load(model_file)

@app.route('/', methods=['POST'])
def predict():
    try:
        image_file = request.files['image']
        image = cv2.imdecode(np.frombuffer(image_file.read(), np.uint8), cv2.IMREAD_COLOR)
        features = extract_features(image)
        prediction = saved_model.predict(features.reshape(1,-1))[0]

        return jsonify({'prediction': prediction})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
