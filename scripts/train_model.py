# train_model.py
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.optimizers import Adam

def train_model(data_path, model_path):
    # Load integrated data
    data = pd.read_csv(data_path)
    
    # Split data into training and testing sets
    X = data.drop(columns=['label'])
    y = data['label']
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Define machine learning model
    rf_model = RandomForestClassifier(n_estimators=100, random_state=42)
    rf_model.fit(X_train, y_train)
    
    # Define deep learning model
    dl_model = Sequential([
        Dense(128, input_dim=X_train.shape[1], activation='relu'),
        Dropout(0.5),
        Dense(64, activation='relu'),
        Dropout(0.5),
        Dense(1, activation='sigmoid')
    ])
    dl_model.compile(optimizer=Adam(learning_rate=0.001), loss='binary_crossentropy', metrics=['accuracy'])
    dl_model.fit(X_train, y_train, epochs=50, batch_size=32, validation_data=(X_test, y_test))
    
    # Save models
    rf_model_path = model_path + '/rf_model.pkl'
    dl_model_path = model_path + '/dl_model.h5'
    
    with open(rf_model_path, 'wb') as f:
        pickle.dump(rf_model, f)
    
    dl_model.save(dl_model_path)
    
train_model("path/to/integrated_data.csv", "path/to/models")
