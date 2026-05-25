---
name: governance
description: Loads the Identity layer (VALUES, BOUNDARIES, EXPECTATIONS) into active context.
---
# Skill: Governance Bootstrap

Trigger: Always load this skill at the beginning of any new project initiation or major workstream to ensure the agent is operating within your defined Identity Layer.

## Description
This skill ensures that the agent is aligned with your identity and governance files. It pulls the content from `~/Projects/agents/hermes/identity/` and injects it into the active conversation memory.

Note: SOUL.md is always-on via `~/.hermes/SOUL.md` and does not need explicit loading here.

## Procedures
1. Read the contents of the following files:
   - `~/Projects/agents/hermes/identity/VALUES.md`
   - `~/Projects/agents/hermes/identity/BOUNDARIES.md`
   - `~/Projects/agents/hermes/identity/EXPECTATIONS.md`
2. Synthesize these into the current session's "Identity/Governance" context.
3. Confirm alignment with the user before proceeding with any mission-critical tasks.

## Verification
- Confirm that the agent has acknowledged the core principles defined in the files.
- Verify that the agent's tone and boundary adherence match the loaded docs.
- Confirm the agent understands the mode-shift spectrum in SOUL.md (banter ↔ analysis).
