## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-10 - Insecure Randomness in Deck Shuffle
**Vulnerability:** `Deck` used `underscore.shuffle()` which relies on `Math.random()`. This is predictable and unsuitable for cryptographic/gambling purposes.
**Learning:** `Math.random()` is not cryptographically secure. Standard libraries like Underscore often use it by default.
**Prevention:** Implement Fisher-Yates shuffle using `window.crypto.getRandomValues()` for game-critical randomness.
