from fastapi import FastAPI
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware
import joblib
import numpy as np

model = joblib.load("best_model.pkl")
scaler = joblib.load("scaler.pkl")


class SessionData(BaseModel):
    SessionLengthMin: float = Field(..., gt=0, lt=500)
    TotalPrompts: int = Field(..., ge=0, le=100)
    AI_AssistanceLevel: int = Field(..., ge=0, le=5)
    UsedAgain: int = Field(..., ge=0, le=1)
    StudentLevel_Undergraduate: int = Field(..., ge=0, le=1)
    StudentLevel_High_Shcool: int = Field(..., ge=0, le=1)
    Discipline_Business: int = Field(..., ge=0, le=1)
    Discipline_Computer_Science: int = Field(..., ge=0, le=1)
    Discipline_Engineering: int = Field(..., ge=0, le=1)
    Discipline_History: int = Field(..., ge=0, le=1)
    Discipline_Math: int = Field(..., ge=0, le=1)
    Discipline_Psychology: int = Field(..., ge=0, le=1)
    TaskType_Coding: int = Field(..., ge=0, le=1)
    TaskType_Homework_Help: int = Field(..., ge=0, le=1)
    TaskType_Research: int = Field(..., ge=0, le=1)
    TaskType_Studying: int = Field(..., ge=0, le=1)
    TaskType_Writing: int = Field(..., ge=0, le=1)
    FinalOutcome_Confused: int = Field(..., ge=0, le=1)
    FinalOutcome_Gave_Up: int = Field(..., ge=0, le=1)
    FinalOutcome_Idea_Drafted: int = Field(..., ge=0, le=1)

app = FastAPI()

#adding CORS middlesware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)



@app.post("/predict")
def predict_satisfaction(data: SessionData):
    input_array = np.array([
        data.SessionLengthMin,
        data.TotalPrompts,
        data.AI_AssistanceLevel,
        data.UsedAgain,
        data.StudentLevel_Undergraduate,
        data.StudentLevel_High_Shcool,
        data.Discipline_Business,
        data.Discipline_Engineering,
        data.Discipline_Computer_Science,
        data.Discipline_History,
        data.Discipline_Math,
        data.Discipline_Psychology,
        data.TaskType_Coding,
        data.TaskType_Homework_Help,
        data.TaskType_Research,
        data.TaskType_Studying,
        data.TaskType_Writing,
        data.FinalOutcome_Confused,
        data.FinalOutcome_Idea_Drafted,
        data.FinalOutcome_Gave_Up
    ]).reshape(1, -1)

    input_scaled = scaler.transform(input_array)
    prediction = model.predict(input_scaled)

    return {"Predicted Satisfaction Rating": round(float(prediction[0]), 2)}