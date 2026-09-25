from pydantic import BaseModel, Field


class RequirementMatch(BaseModel):
    requirement_id: str
    semantic_score: float = Field(ge=0)
    reason: str = ""


class RequirementMatchResponse(BaseModel):
    query: str
    matches: list[RequirementMatch]
