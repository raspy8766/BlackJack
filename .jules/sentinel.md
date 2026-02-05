## 2026-02-02 - Unescaped Template Interpolation
**Vulnerability:** Found `<%= %>` usage in Underscore templates for `CardView`, which interpolates raw HTML. This creates XSS risk if model attributes contain malicious scripts.
**Learning:** Underscore/Backbone templates default to raw interpolation (`<%= %>`). Escaping (`<%- %>`) must be chosen explicitly.
**Prevention:** Always use `<%- %>` for variable interpolation in templates unless rendering trusted HTML is intentional.

## 2026-02-02 - Active Debug Code in Production
**Vulnerability:** Found a `debugger` statement in `CardView.render` method. This stops execution in the browser if developer tools are open, potentially causing Denial of Service or annoyance for users, and exposing internal state.
**Learning:** Developers sometimes leave debug code (`debugger`, `console.log`) in source files which gets compiled into production artifacts.
**Prevention:** Use linters with rules like `no-debugger` to catch this before commit.
