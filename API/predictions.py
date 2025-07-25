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
    StudentLevel_Intermediate: int = Field(..., ge=0, le=1)
    StudentLevel_Senior: int = Field(..., ge=0, le=1)
    Discipline_Engineering: int = Field(..., ge=0, le=1)
    Discipline_Science: int = Field(..., ge=0, le=1)
    TaskType_Research: int = Field(..., ge=0, le=1)
    TaskType_Study: int = Field(..., ge=0, le=1)
    FinalOutcome_Success: int = Field(..., ge=0, le=1)

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
        data.StudentLevel_Intermediate,
        data.StudentLevel_Senior,
        data.Discipline_Engineering,
        data.Discipline_Science,
        data.TaskType_Research,
        data.TaskType_Study,
        data.FinalOutcome_Success
    ]).reshape(1, -1)

    input_scaled = scaler.transform(input_array)
    prediction = model.predict(input_scaled)

    return {"Predicted Satisfaction Rating": round(float(prediction[0]), 2)}