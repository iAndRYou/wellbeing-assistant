from keras.models import Model
from keras.layers import Input, LSTM, Dense, Embedding, Flatten, Concatenate, Dropout, Masking, concatenate
from keras.optimizers import Adam
import keras
from api.enums import MealType, ExerciseType


def build_meal_model():
    # Configuration parameters
    sequence_length = 10  # Example sequence length of meal history
    num_features = 12  # Number of features per meal, adjust based on your actual feature set
    num_meal_features = 7  # Assuming the specific meal uses the same feature set

    # Inputs
    historical_meals_input = Input(shape=(sequence_length, num_features), name='historical_meals')
    specific_meal_input = Input(shape=(num_meal_features,), name='specific_meal')

    # Mask historical meals
    historical_meals_input = Masking(mask_value=0.0)(historical_meals_input)

    # Historical meals pathway
    lstm_out = LSTM(64)(historical_meals_input)
    lstm_dropout = Dropout(0.5)(lstm_out)

    # Specific meal pathway
    specific_meal_dense = Dense(64, activation='relu')(specific_meal_input)
    specific_meal_dropout = Dropout(0.5)(specific_meal_dense)

    # Merge pathways
    merged = concatenate([lstm_dropout, specific_meal_dropout])

    # Further processing
    merged_dense = Dense(64, activation='relu')(merged)
    output_dropout = Dropout(0.5)(merged_dense)

    # Output layer for well-being score prediction
    well_being_score = Dense(1, activation='linear', name='well_being_output')(output_dropout)

    # Compile the model
    model = Model(inputs=[historical_meals_input, specific_meal_input], outputs=well_being_score)
    model.compile(optimizer=Adam(), loss='mse', metrics=['mae'])

    # Model summary
    model.summary()

    return model


def build_exercise_model():
    # Configuration parameters
    num_exercises = 10  # Number of unique exercises to choose from
    sequence_length = 10  # Example sequence length of exercise history
    num_features = 2  # Number of features per exercise (excluding 'name' for simplicity)

    # Model architecture
    input_layer = Input(shape=(sequence_length, num_features))

    # Masking layer for pre-padding
    # masked_layer = Masking(mask_value=0.0)(input_layer),  

    # LSTM layer(s)
    lstm_out = LSTM(64)(input_layer)  # Adjust based on dataset complexity

    # Adding a dropout layer for regularization
    dropout_out = Dropout(0.5)(lstm_out)

    # Dense layer(s) for further interpretation
    dense_out = Dense(32, activation='relu')(dropout_out)

    # Output layer predicts the well-being score
    well_being_score = Dense(1, activation='linear', name='well_being_output')(dense_out)

    # Compile the model
    model = Model(inputs=input_layer, outputs=well_being_score)
    model.compile(optimizer='adam', loss='mse', metrics=['mae'])

    # Model summary
    model.summary()

    # Placeholder for training the model
    # X_train represents sequences of past meals, and y_train represents the well-being scores
    # model.fit(X_train, y_train, epochs=10, batch_size=32)

    return model


def pretrain_meal_model(model, X_train_meal_history, X_train_meal, y_train):
    # Pad the meal history sequences to a fixed length of 10
    X_train_meal_history = keras.preprocessing.sequence.pad_sequences(X_train_meal_history, maxlen=10, padding='post', truncating='post')
    
    # Pre-training the meal model
    history = model.fit([X_train_meal_history, X_train_meal], y_train, epochs=20, batch_size=1, validation_split=0.2, verbose=1)

    return history

def pretrain_exercise_model(model, X_train, y_train):
    # Pre-training the exercise model
    history = model.fit(X_train, y_train, epochs=20, batch_size=1)

    return history