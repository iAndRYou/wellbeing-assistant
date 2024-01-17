from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from models.database import db
from models.entities import *

app = FastAPI(
    title="Wellbeing Assistant API"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

db.connect()

db.create_tables([], safe=True)

@app.get("/")
async def root():
    return {"message": "Hello World"}