## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-08 - Insecure Random Number Generation
**Vulnerability:** The deck shuffling algorithm relied on `Math.random()`, which is not cryptographically secure and predictable, allowing card prediction.
**Learning:** `Math.random()` should never be used for security-sensitive operations or gambling logic.
**Prevention:** Use `window.crypto.getRandomValues()` for generating random numbers in security-sensitive contexts.
