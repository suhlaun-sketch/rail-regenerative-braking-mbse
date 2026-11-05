export function mountShadowTemplate(host: HTMLElement, styles: string, markup: string): ShadowRoot {
  const root = host.shadowRoot ?? host.attachShadow({mode: 'open'})
  const style = document.createElement('style')
  style.textContent = styles
  const template = document.createElement('template')
  template.innerHTML = markup
  root.replaceChildren(style, template.content.cloneNode(true))
  return root
}
