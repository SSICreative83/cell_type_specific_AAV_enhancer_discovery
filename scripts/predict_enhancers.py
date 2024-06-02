# predict_enhancers.py
import pandas as pd
import pickle
from tensorflow.keras.models import load_model

def predict_enhancers(data_path, model_path, output_path):
    # Load integrated data
    data = pd.read_csv(data_path)
    
    # Load models
    rf_model_path = model_path + '/rf_model.pkl'
    dl_model_path = model_path + '/dl_model.h5'
    
    with open(rf_model_path, 'rb') as f:
        rf_model
