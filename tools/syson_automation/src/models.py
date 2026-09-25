from __future__ import annotations

from datetime import datetime
from typing import Any, Literal

from pydantic import BaseModel, ConfigDict, Field


class StrictModel(BaseModel):
    model_config = ConfigDict(extra="forbid")


class ScopeRequest(StrictModel):
    query: str = Field(min_length=2, max_length=500)


class Evidence(StrictModel):
    source: str
    id: str | None = None
    text: str


class RequirementScopeItem(StrictModel):
    id: str
    name: str
    requirement_level: str
    source_type: str
    score: float = 0
    evidence: list[Evidence] = Field(default_factory=list)
    parent_requirement_ids: list[str] = Field(default_factory=list)
    derived_requirement_ids: list[str] = Field(default_factory=list)


class FunctionScopeItem(StrictModel):
    id: str
    name: str
    owner_product_id: str
    owner_product_name: str
    evidence: list[Evidence] = Field(default_factory=list)


class ProductScopeItem(StrictModel):
    id: str
    name: str
    level: int | str | None = None
    role: Literal["OWNER", "INTERACTION_NEIGHBOR", "HIERARCHY_ANCESTOR"]
    evidence: list[Evidence] = Field(default_factory=list)


class ClosureWitness(StrictModel):
    neighbor_product_id: str
    interface_ref: str | None = None
    flow_ref: str | None = None
    connector_refs: list[str] = Field(default_factory=list)


class ProductClosureNode(StrictModel):
    product_id: str
    product_name: str
    canonical_name: str
    source_element_ids: list[str] = Field(default_factory=list)
    seed: bool
    introduced_at_round: int
    introduced_by: list[ClosureWitness] = Field(default_factory=list)


class ProductClosureEdge(StrictModel):
    source_product_id: str
    target_product_id: str
    flow_refs: list[str] = Field(default_factory=list)
    interface_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    directions: list[str] = Field(default_factory=list)
    flow_kinds: dict[str, int] = Field(default_factory=dict)
    evidence_sources: list[str] = Field(default_factory=list)


class CanonicalProduct(StrictModel):
    canonical_id: str
    display_name: str
    source_product_ids: list[str]
    source_element_ids: list[str] = Field(default_factory=list)
    source_allocation_refs: list[str] = Field(default_factory=list)
    interface_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    flow_refs: list[str] = Field(default_factory=list)
    merge_kind: Literal["IDENTITY", "EXPLICIT_VISUAL_OCCURRENCE"] = "IDENTITY"


class HierarchyNode(StrictModel):
    product_id: str
    product_name: str
    level: int
    parent_product_id: str | None = None
    child_product_ids: list[str] = Field(default_factory=list)
    hierarchy_path: list[str] = Field(default_factory=list)
    role: Literal["OWNER", "INTERACTION_NEIGHBOR", "HIERARCHY_ANCESTOR"]


class InterfaceScopeItem(StrictModel):
    id: str
    name: str
    interface_refs: list[str] = Field(default_factory=list)
    flow_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)


class FlowScopeItem(StrictModel):
    source_product_id: str
    target_product_id: str
    flow_name: str
    flow_kind: str
    flow_ref: str
    interface_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    evidence: str = ""


class IBDProduct(StrictModel):
    product_id: str
    name: str
    level: int
    parent_product_id: str | None = None
    canonical_product_id: str | None = None


class IBDConnection(StrictModel):
    source_product_id: str
    source_element_id: str
    target_product_id: str
    target_element_id: str
    interface_refs: list[str] = Field(default_factory=list)
    flow_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    evidence_type: Literal["EXPLICIT_CONNECTOR", "EXPLICIT_FLOW", "DERIVED_BOUNDARY"]
    # Compatibility/aggregation fields for current plan consumers.
    aggregated_from_flow_refs: list[str] = Field(default_factory=list)
    aggregated_from_interface_refs: list[str] = Field(default_factory=list)
    aggregated_from_connector_refs: list[str] = Field(default_factory=list)
    source: str | None = None
    target: str | None = None
    source_canonical_id: str | None = None
    target_canonical_id: str | None = None


class IBDBoundaryPort(StrictModel):
    port_id: str
    parent_product_id: str
    child_product_id: str
    source_product_id: str
    source_element_id: str
    target_product_id: str
    target_element_id: str
    interface_refs: list[str] = Field(default_factory=list)
    flow_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    evidence_type: Literal["DERIVED_BOUNDARY"] = "DERIVED_BOUNDARY"


class IBDEvidenceSummary(StrictModel):
    connection_count: int = 0
    internal_connection_count: int = 0
    boundary_port_count: int = 0
    boundary_link_count: int = 0
    external_connection_count: int = 0
    evidence_type_counts: dict[str, int] = Field(default_factory=dict)


class ViewSpec(StrictModel):
    name: str
    view_type: Literal["REQUIREMENT", "FUNCTION_PRODUCT", "IBD"]
    status: str = "PLANNED"
    requirement_ids: list[str] = Field(default_factory=list)
    function_ids: list[str] = Field(default_factory=list)
    product_ids: list[str] = Field(default_factory=list)
    interface_refs: list[str] = Field(default_factory=list)
    flow_refs: list[str] = Field(default_factory=list)
    connector_refs: list[str] = Field(default_factory=list)
    evidence: list[str] = Field(default_factory=list)
    hierarchy_level: int | None = None
    canonical_product_ids: list[str] = Field(default_factory=list)
    projected_interactions: list[dict[str, Any]] = Field(default_factory=list)
    # Structured, evidence-carrying nested IBD projection. Boundary port ids are
    # view-local projections of real flows/connectors, not new SysML elements.
    view_id: str | None = None
    level: int | None = None
    products: list[IBDProduct] = Field(default_factory=list)
    internal_connections: list[IBDConnection] = Field(default_factory=list)
    boundary_ports: list[IBDBoundaryPort] = Field(default_factory=list)
    boundary_links: list[IBDConnection] = Field(default_factory=list)
    external_connections: list[IBDConnection] = Field(default_factory=list)
    evidence_summary: IBDEvidenceSummary = Field(default_factory=IBDEvidenceSummary)
    parent_view_name: str | None = None
    child_view_names: list[str] = Field(default_factory=list)


class ContainerIBDViewSpec(StrictModel):
    view_id: str
    view_name: str
    container_product_id: str
    container_product_name: str
    hierarchy_level: int
    drilldown_depth: int
    direct_children: list[dict[str, Any]] = Field(default_factory=list)
    internal_connections: list[dict[str, Any]] = Field(default_factory=list)
    real_boundary_ports: list[dict[str, Any]] = Field(default_factory=list)
    virtual_boundary_projections: list[dict[str, Any]] = Field(default_factory=list)
    boundary_links: list[dict[str, Any]] = Field(default_factory=list)
    external_endpoints: list[dict[str, Any]] = Field(default_factory=list)
    external_connections: list[dict[str, Any]] = Field(default_factory=list)
    drilldown_targets: list[dict[str, Any]] = Field(default_factory=list)
    parent_container_id: str | None = None
    evidence_summary: dict[str, Any] = Field(default_factory=dict)


class ScopeViewPlan(StrictModel):
    requirement_view: ViewSpec
    function_product_view: ViewSpec
    hierarchical_ibd_views: list[ViewSpec] = Field(default_factory=list)
    full_hierarchy_projection: list[ViewSpec] = Field(default_factory=list)
    container_ibd_views: list[ContainerIBDViewSpec] = Field(default_factory=list)
    # Backward-compatible alias for clients of the first local API iteration.
    ibd_views: list[ViewSpec] = Field(default_factory=list)


class EngineeringScopeManifest(StrictModel):
    scope_id: str
    query: str
    created_at: datetime
    query_provider: str
    requirements: list[RequirementScopeItem]
    functions: list[FunctionScopeItem]
    products: list[ProductScopeItem]
    interfaces: list[InterfaceScopeItem]
    flows: list[FlowScopeItem]
    seed_products: list[str] = Field(default_factory=list)
    product_closure: list[ProductClosureNode] = Field(default_factory=list)
    closure_edges: list[ProductClosureEdge] = Field(default_factory=list)
    canonical_products: list[CanonicalProduct] = Field(default_factory=list)
    hierarchy_nodes: list[HierarchyNode] = Field(default_factory=list)
    hierarchical_ibd_views: list[ViewSpec] = Field(default_factory=list)
    full_hierarchy_projection: list[ViewSpec] = Field(default_factory=list)
    container_ibd_views: list[ContainerIBDViewSpec] = Field(default_factory=list)
    closure_stats: dict[str, Any] = Field(default_factory=dict)
    view_plan: ScopeViewPlan
    limits_applied: list[str] = Field(default_factory=list)
    source_hashes: dict[str, str] = Field(default_factory=dict)
    diagnostics: list[str] = Field(default_factory=list)
    raw_stats: dict[str, Any] = Field(default_factory=dict)
