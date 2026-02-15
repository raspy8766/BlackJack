## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-02 - Predictable Randomness in Shuffling
**Vulnerability:** Used `Math.random()` for shuffling via Underscore's `shuffle`, which is not cryptographically secure and allows predictable game states.
**Learning:** Standard library random functions are often pseudo-random and unfit for security-sensitive operations like card shuffling.
**Prevention:** Use `window.crypto.getRandomValues` for generating random numbers in security-critical contexts.
