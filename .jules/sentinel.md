## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-02 - Predictable Random Number Generation
**Vulnerability:** `_.shuffle` (and `Math.random`) is not cryptographically secure, making card decks predictable.
**Learning:** Standard library functions often use weak PRNGs. For game mechanics involving chance (especially gambling), use `window.crypto.getRandomValues`.
**Prevention:** Implement Fisher-Yates shuffle with `window.crypto.getRandomValues` instead of relying on `_.shuffle` or `Math.random`.
