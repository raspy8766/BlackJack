## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-10-27 - Insecure Random Number Generation
**Vulnerability:** `Deck.coffee` used `Math.random()` (via `underscore.shuffle`) for deck shuffling. This allows for predictable deck ordering, compromising game fairness.
**Learning:** Default shuffling methods in libraries like Underscore often rely on `Math.random`, which is not cryptographically secure.
**Prevention:** Implement a custom Fisher-Yates shuffle using `window.crypto.getRandomValues` for any game logic involving chance or randomness.
