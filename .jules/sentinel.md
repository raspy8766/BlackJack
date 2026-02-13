## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-13 - Weak RNG in Deck Shuffle
**Vulnerability:** Found usage of `_().shuffle()` (Underscore.js) in `Deck.coffee`, which relies on `Math.random()`. This makes card order predictable.
**Learning:** Default library shuffle functions often use weak PRNGs. Games of chance require CSPRNG.
**Prevention:** Use `window.crypto.getRandomValues` with Fisher-Yates shuffle for any game logic involving randomness.
