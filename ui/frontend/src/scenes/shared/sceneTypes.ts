export interface SceneController<TSnapshot, TEvent, TDiagnostics = unknown> {
  setSnapshot(snapshot: TSnapshot): void
  dispatch(event: TEvent): void
  resize(): void
  focus(id: string | null): void
  getDiagnostics(): TDiagnostics
  dispose(): void
}
