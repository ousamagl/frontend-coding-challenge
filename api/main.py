from fastapi import FastAPI, HTTPException, Header, Depends, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import json
from typing import List, Optional
from datetime import datetime, date

from jose import JWTError, jwt
from datetime import timedelta
import os

app = FastAPI()

SECRET_KEY = "crewmeister"

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def load_json(file_name: str):
    file_path = os.path.join(os.path.dirname(__file__), 'json_files', file_name)
    with open(file_path, 'r') as f:
        return json.load(f)

def get_current_user(authorization: str = Header(...)):
    if not authorization:
        raise HTTPException(status_code=401, detail="Authorization header is missing")
    
    if authorization.startswith("Bearer "):
        token = authorization[7:].strip()
    else:
        raise HTTPException(status_code=401, detail="Invalid authorization code")
    
    try:
        decoded_token = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        
        if decoded_token["exp"] < datetime.utcnow().timestamp():
            raise HTTPException(status_code=401, detail="Token has expired")
        
        return decoded_token["sub"]
    
    except JWTError as e:
        raise HTTPException(status_code=401, detail="Invalid token or token has expired")


class Absence(BaseModel):
    id: int
    userId: int
    crewId: int
    startDate: datetime
    endDate: datetime
    admitterId: Optional[int] = None
    admitterNote: Optional[str] = None
    createdAt: Optional[datetime] = None
    confirmedAt: Optional[datetime] = None
    rejectedAt: Optional[datetime] = None
    memberNote: Optional[str] = None
    type: Optional[str] = None
    status: Optional[str] = None

class Member(BaseModel):
    crewId: int
    id: int
    image: str
    name: str
    userId: int

class LoginRequest(BaseModel):
    username: str
    password: str

@app.post("/login")
async def login(request: LoginRequest):
    admins = load_json("admin.json")
    
    admin = next((admin for admin in admins if admin["username"] == request.username), None)
    
    if not admin or admin["password"] != request.password:
        raise HTTPException(status_code=401, detail="Invalid username or password")

    expiration = datetime.utcnow() + timedelta(weeks=1)
    
    token = jwt.encode({"sub": request.username, "exp": expiration}, SECRET_KEY, algorithm="HS256")
    
    return {"access_token": token}

def get_status(absence: dict) -> str:
    confirmed_at = absence.get('confirmedAt')
    rejected_at = absence.get('rejectedAt')
    
    if confirmed_at and rejected_at:
        return None 
    elif confirmed_at:
        return "confirmed"
    elif rejected_at:
        return "rejected"
    else:
        return "requested"

@app.get("/absences", response_model=List[Absence])
async def get_absences(
    skip: int = 0,
    limit: int = 10,
    current_user: str = Depends(get_current_user),
    type: Optional[str] = Query(None), 
    status: Optional[str] = Query(None),
    crew_id: Optional[int] = Query(None),
    user_id: Optional[int] = Query(None),
    start_date: Optional[date] = Query(None),
    end_date: Optional[date] = Query(None)
):
    absences = load_json("absences.json")

    filtered_absences = absences

    if type:
        filtered_absences = [
            absence for absence in filtered_absences if absence.get('type') == type
        ]
    
    if status:
        filtered_absences = [
            absence for absence in filtered_absences if get_status(absence) == status
        ]
    
    if crew_id:
        filtered_absences = [
            absence for absence in filtered_absences if absence.get('crewId') == crew_id
        ]
    
    if user_id:
        filtered_absences = [
            absence for absence in filtered_absences if absence.get('userId') == user_id
        ]
    
    if start_date and end_date:
        filtered_absences = [
            absence for absence in filtered_absences
            if date.fromisoformat(absence.get('startDate')) >= start_date and date.fromisoformat(absence.get('endDate')) <= end_date
        ]
    elif start_date:
        filtered_absences = [
            absence for absence in filtered_absences
            if date.fromisoformat(absence.get('startDate')) == start_date
        ]
    elif end_date:
        filtered_absences = [
            absence for absence in filtered_absences
            if date.fromisoformat(absence.get('endDate')) == end_date
        ]
    
    return filtered_absences[skip: skip + limit]

@app.get("/total-absences")
async def get_total_absences(current_user: str = Depends(get_current_user)):
    try:
        absences = load_json("absences.json")
        
        total_absences = len(absences)
        
        return {"total_absences": total_absences}
    
    except json.JSONDecodeError:
        raise HTTPException(status_code=400, detail="Error decoding absences.json file")
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Unexpected error: {e}")


@app.get("/members", response_model=List[Member])
async def get_members(current_user: str = Depends(get_current_user)):
    members = load_json("members.json")
    return members