## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-03 - Insecure Random Number Generation in Game Logic
**Vulnerability:** The Deck collection used `_.shuffle` (based on `Math.random()`) to shuffle cards. This allows deck prediction, compromising the integrity of the Blackjack game.
**Learning:** `Math.random()` is not cryptographically secure and should not be used for gambling mechanics or security-sensitive randomization.
**Prevention:** Use `window.crypto.getRandomValues()` combined with a bias-free rejection sampling algorithm for random number generation in game mechanics.
