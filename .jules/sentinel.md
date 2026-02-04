## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-04 - Weak Random Number Generation in Deck Shuffle
**Vulnerability:** Used `Math.random()` via `_.shuffle` for card shuffling, which is not cryptographically secure and allows predictability of the deck.
**Learning:** `Math.random()` is insufficient for security-sensitive operations like gambling or card games.
**Prevention:** Use `window.crypto.getRandomValues()` for shuffling logic.
