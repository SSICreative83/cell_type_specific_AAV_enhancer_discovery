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
                rf_model = pickle.load(f)
    
    dl_model = load_model(dl_model_path)
    
    # Prepare data for prediction
    X = data.drop(columns=['label'])
    
    # Make predictions with both models
    rf_predictions = rf_model.predict(X)
    dl_predictions = dl_model.predict(X)
    
    # Combine predictions (for example, using majority vote or averaging)
    combined_predictions = (rf_predictions + dl_predictions) / 2
    
    # Save predictions to output file
    output_df = pd.DataFrame({
        'cell_id': data['cell_id'],
        'prediction': combined_predictions
    })
    output_df.to_csv(output_path, index=False)
    
predict_enhancers("path/to/integrated_data.csv", "path/to/models", "path/to/output/predictions.csv")

