from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field


class SemanticQuery(BaseModel):
    query: str = Field(min_length=1, max_length=500)
    mode: str = Field(default="auto", pattern="^(auto|local)$")


def semantic_router(service):
    router = APIRouter(prefix="/api/semantic", tags=["semantic"])

    @router.get("/catalog")
    def catalog(): return service.summary()

    @router.get("/status")
    def status(): return service.status()

    @router.get("/requirements")
    def requirements(): return service.catalog.requirements

    @router.get("/functions")
    def functions(): return service.catalog.functions

    @router.get("/products")
    def products(): return service.catalog.products

    @router.get("/requirement/{requirement_id}")
    def requirement(requirement_id: str):
        value = service.catalog.requirement_detail(requirement_id)
        if value is None: raise HTTPException(404, "Requirement不存在")
        return value

    @router.get("/function/{function_id}")
    def function(function_id: str):
        value = service.catalog.function_detail(function_id)
        if value is None: raise HTTPException(404, "Function不存在")
        return value

    @router.get("/product/{product_id}")
    def product(product_id: str):
        value = service.catalog.product_detail(product_id)
        if value is None: raise HTTPException(404, "Product不存在")
        return value

    @router.post("/query")
    async def query(value: SemanticQuery):
        try: return await service.query(value.query, value.mode)
        except ValueError as error: raise HTTPException(422, str(error)) from error

    return router
