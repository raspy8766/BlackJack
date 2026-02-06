## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-06 - Weak Random Number Generation
**Vulnerability:** Found usage of `Math.random()` via Underscore's `shuffle` for shuffling the deck. `Math.random()` is not cryptographically secure and can be predictable.
**Learning:** `Math.random()` is a PRNG, not a CSPRNG. In gaming contexts, this can lead to predictable outcomes.
**Prevention:** Use `window.crypto.getRandomValues()` for randomness in security-sensitive or fairness-sensitive contexts (like card shuffling). Implemented a custom Fisher-Yates shuffle using CSPRNG.
