#!/usr/bin/python3
import pandas as pd
import os
data = pd.read_csv("pima_indians_diabetes.csv", header=None)
y = data[8]
X = data[[0,1,2,3,4,5,6,7]]

from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import Adam

model=Sequential()
model.add(Dense(input_dim=8, units=6, activation = 'relu'))
model.add(Dense(units=8, activation = 'relu'))
model.add(Dense(units=1, activation ='sigmoid'))
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(X,y, epochs=100)
model.save("pima_indians_diabetes_model.h5")

os.system("python3 app.py")
