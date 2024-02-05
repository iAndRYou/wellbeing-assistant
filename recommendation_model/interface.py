from keras.models import load_model
from recommendation_model.preprocessing import *

def load_model_meals():
    return load_model('recommendation_model/model_meals.h5')

def load_model_exercises():
    return load_model('recommendation_model/model_exercises.h5')


def save_model_meals(model):
    model.save('recommendation_model/model_meals.h5')

def save_model_exercises(model):
    model.save('recommendation_model/model_exercises.h5')



def get_meal_recommendation(meal_history, available_meals):
    model = load_model_meals()

    # preprocess the meal history
    meal_history = preprocess_meals(meal_history)

    # iterate through each meal in available_meals
    # and 5 weights for each meal, between mu - 2*sigma and mu + 2*sigma, where mu is the mean and sigma is the standard deviation for the weights in meal history
    # and calculate the well-being score for each meal
    well_being_scores = {}
    for meal in available_meals:
        for i in range(5):
            meal_copy = meal.copy()
            mu = meal_history['weight'].mean()
            sigma = meal_history['weight'].std()
            meal_copy['weight'] = mu - 2*sigma + (i/4) * 4*sigma
            print(meal_history)
            print(meal_copy)
            meal_copy = preprocess_meal_target(meal_copy)
            well_being_score = model.predict([meal_history.to_numpy().reshape(1, 10, 12), meal_copy.to_numpy().reshape(1, 7)])
            well_being_scores[(meal["id"], meal_copy.iloc[0]['weight'])] = well_being_score


    # make the recommendation
    # well_being_scores is a dictionary with keys being tuples of (meal id, weight) and values being the well-being score
    # we want to find the meal and weight that has the highest well-being score
    tup = max(well_being_scores, key=well_being_scores.get)

    recommended_meal_id = tup[0]
    recommended_meal_weight = tup[1]

    recommended_meal = [available_meals for meal in available_meals if meal['id'] == recommended_meal_id][0]
    recommended_meal['weight'] = recommended_meal_weight

    return recommended_meal


# def feedback()