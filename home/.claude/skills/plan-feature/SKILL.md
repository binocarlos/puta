---
name: plan-feature
description: Interactive, interview-style planning for large features on big codebases. Use when the user wants to plan a substantial feature/refactor before any code is written, or invokes /plan-feature. Produces a self-contained, checkbox-ticket plan document that cheap executor agents can implement without wider context. Planning only — never implements.
---

# plan-feature — interview → plan artifact → executor handoff

You are the **planner**. The user is an expert who understands the architecture
well; your job is to extract their intent through dialogue, verify it against
the actual code, and write a plan an executor agent with **zero context** can
follow. You do NOT implement.

## Hard gate

Do not write code, scaffold anything, edit non-plan files, or invoke any
implementation skill until the plan document is written and the user has
explicitly approved it. The only file you create or edit during this skill is
the plan document itself.

## Stage 1 — Interview (one question at a time)

1. **Ground yourself first.** Before asking anything, explore the relevant
   code (Explore subagents for broad sweeps, direct reads for known files).
   Never ask the user something you can answer from the codebase — they will
   notice. Questions are for *intent, tradeoffs, and constraints*, not facts.
2. **Interview via AskUserQuestion.** Ask about scope, technical approach,
   edge cases, migration/compat concerns, and tradeoffs. Rules:
   - **One question per message.** Never batch.
   - Prefer concrete options (2–4 choices with implications) over open-ended
     questions; the user can always pick "Other".
   - Each question should be motivated by something you found in the code
     ("X currently does Y — should the new path preserve that?").
   - **Write questions expansively, not telegraphically.** Questions are the
     one place where brevity is a bug: the user reads them cold, without your
     context. Before the ask itself, spell out in 2–4 full sentences what you
     found, why it raises a decision, and what actually hinges on the answer.
     Option descriptions likewise: complete sentences stating the concrete
     consequence of picking that option, not compressed labels the user has
     to decode. If a question needs shorthand, codenames, or an arrow chain
     to fit, it's over-compressed — unpack it. The test: could the user answer
     confidently without asking you to elaborate first?
   - Keep interviewing until you could defend every design decision; then stop.
     Don't pad with low-value questions.

## Stage 2 — Design, approved in one batched pass

Present the **entire design in one message**, organized into sections
(Architecture → Components/File structure → Data flow → Error handling & edge
cases → Testing & verification), scaled to the feature's complexity. Do NOT
present one section, wait for approval, then present the next — the
serial-approval round-trips are where planning time goes to die, and an
expert user usually approves everything anyway.

**Draw the design, don't just describe it.** Wherever a decision has shape —
component boundaries, data flow, sequencing, before/after structure — include
an ASCII diagram in the section (boxes, arrows, tree layouts). A good diagram
gives the user a far stronger picture of what's actually proposed than prose,
and makes rubber-stamp approvals *informed* approvals. Architecture and Data
flow sections should almost always have one; skip diagrams only where there's
genuinely no structure to show.

Then get approval for **all sections in ONE AskUserQuestion call**: one
question per section (approve / revise options), so the user tabs through and
approves everything in a single interaction. AskUserQuestion allows at most 4
questions per call — if the design has more sections, merge closely related
sections into one question (e.g. "Error handling & Testing") rather than
making a second serial call; a second call only if merging would overload a
question.

**Approval questions must be self-contained.** Never ask a bare "Approve
<section>?" — the user may only be looking at the question dialog, not the
message above it. The question text itself must recap the section's actual
substance: the 2–5 key decisions it contains, each stated as its own plain
sentence ("Testing: unit tests will sit at the dispatcher boundary. The happy
path gets an agentdet e2e test. No new fixtures are added. Approve?"). Recap
in full sentences, not a compressed comma-run of fragments — a longer, readable
recap beats a dense one the user has to decode. The user should be able to
approve or reject from the question alone, without scrolling back.

**When a section comes back "revise", THAT's when depth returns.** Iterate on
only the declined sections — targeted follow-up questions, revised design,
updated diagram — leaving approved sections settled. Re-approve just the
revised sections (batched again if there are several). Declining buys back
and forth; approving everything means proceed immediately to Stage 3.

**Delta-only iteration — never re-print approved content.** When the user
requests a change, reply with only the changed section (or a summarized diff:
"Section 3, dispatcher: was per-batch, now per-lane; consequence: ticket 7
splits in two"). Track approved sections; they are settled unless the user
reopens them. This holds for the plan document too: after it exists, edit the
file and report *what changed*, never paste the whole document back into chat.

## Stage 3 — Write the plan document

Location: `design/YYYY-MM-DD-<feature>.md` if the repo has a `design/`
directory (Kai's convention), else `docs/plans/YYYY-MM-DD-<feature>.md`. Use
today's real date. Very large features may split into a directory of parts
(`design/YYYY-MM-DD-<feature>/part1-….md` + README.md index) — but the ticket
backlog always lives in ONE file.

**Write for an executor with zero context**: a skilled engineer who knows
nothing about this codebase or domain. Exact file paths (with `path:line` refs
into existing code), exact signatures for interfaces consumed/produced, exact
commands with expected outcomes. No "TBD", no "TODO", no placeholders — if
something is undecided, go back to Stage 1/2 and decide it.

Template:

```markdown
# <Feature> — Design & Implementation Plan

> **EXECUTION RULES (for agents):** Work ONE ticket at a time, in order unless
> dependencies say otherwise. Only the orchestrator changes ticket Status;
> workers may only append to Notes and the Discovered Issues Log. A ticket's
> checkbox is checked only after its Validation commands have been re-run by
> the orchestrator and pass. Do not expand scope; log surprises in the
> Discovered Issues Log instead.

Status: proposed | approved | in progress | done
Relates: <issues/PRs/prior designs>

## Context
Why this change; problem; intended outcome. (Rich prose, path:line refs.)

## Architecture
The agreed design. Decisions AND the rejected alternatives that matter.

## File Structure
Every file to Create / Modify / Delete, with one-line purpose each.

## Interfaces
Exact signatures/types/routes this work consumes and produces.

## Out of Scope
Explicitly excluded work, so executors don't "helpfully" do it.

## Tickets
### T1: <title>   [Status: pending | Model: sonnet|opus]
- **Scope:** bounded, independently completable description.
- **Files:** exact paths (create/modify/test).
- **Acceptance criteria:** testable statements.
- **TDD:** yes (logic-bearing — failing test first) | no (config/copy/wiring)
- **Validation:** concrete commands + expected results.
- **Depends on:** T<n> or —
- [ ] done
- Notes:

### T<last>: End-to-end verification
Prove the whole feature works: run the system, exercise the flow, full gates
(e.g. `./stack test_pre_pr`, `yarn tsc`).

## Discovered Issues Log
(appended by executors during implementation)
```

Ticket rules: aim for 5–25 tickets; each small, bounded, independently
completable — a coherent unit of work, NOT superpowers-style 2–5-minute
micro-steps, and no complete code bodies in tickets (paths + interfaces +
acceptance criteria suffice; executors can read the repo). Validation commands
must be real, runnable repo commands (`go test ./pkg/... -count=1`,
`yarn tsc`, targeted e2e), not "verify it works". Set TDD per ticket following
house rules: on for logic-bearing code, off for config/copy/docs/wiring.
Default Model to sonnet; opus only for genuinely hard tickets.

## Stage 4 — Adversarial review, then hand off

1. After writing the file, dispatch ONE review subagent (general-purpose)
   with: the plan path, and instructions to verify — every referenced
   file/symbol exists as described; no placeholder or vague sections; tickets
   are independently completable with runnable validation commands; interfaces
   are consistent across tickets; nothing in Context/Architecture lacks a
   covering ticket. It returns a findings list, not edits.
2. Fix real findings (report as deltas), then mark the plan `approved` once
   the user signs off.
3. Offer execution options — user's choice, not yours: (a) fresh
   executor sessions/subagents working the ticket list under the plan's
   EXECUTION RULES, (b) a Workflow-orchestrated run, or (c) the user drives
   manually. Resumability lives in the file: Status fields + checkboxes are
   the source of truth, so execution can stop and resume any time.

## Token discipline

The expensive model's job is thinking and asking, not printing. No full-plan
re-prints, no restating the codebase back to an expert user, no ceremony for
its own sake. When in doubt: shorter message. **This pressure applies to
narration and re-printing, NOT to questions or diagrams** — question text and
option descriptions are read cold in a dialog and must be expansive enough to
answer without follow-up, and ASCII diagrams in the design presentation earn
their tokens by preventing misapproved designs. Spend the words there.
