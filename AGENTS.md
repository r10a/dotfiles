# global agent instructions

- Never use the em dash "—". Use plain dash "-" instead
- Do not insert hard newlines inside paragraphs. Write each paragraph as one continuous string. Allow text to soft-wrap based on the destination editor.
- When writing commit messages, NEVER auto-add your agent name as co-author.
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long term maintainability.
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user would experience it as possible.
  This makes sure you find the real problem so your fix will actually solve it.
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way.
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed.

## Worktrees (treehouse)
- `treehouse` manages a pool of reusable git worktrees so parallel agents don't collide. Use it instead of `git worktree add` or a second clone; pooled worktrees keep their dependencies and build cache.
- Non-interactive: `path=$(treehouse get --lease --lease-holder <label>)` prints the worktree path to stdout (banners go to stderr). Release with `treehouse return "$path"`, which resets it and returns it to the pool.
- A lease survives with no process inside it and is never handed out or pruned until returned, so always return one you took.
- `treehouse status --json` lists the pool with `path`, `status`, and `lease_holder`. Never `rm -rf` a worktree; use `treehouse return` or `treehouse destroy <path> --yes`.

## Response style
- Default to the shortest answer that fully addresses the request. Lead with the answer, not the reasoning.
- No preamble or postamble. Skip "Here's...", "Great question", and closing summaries.
- Do not restate what I asked or recap what you just did unless I ask.
- When you complete a task, report the outcome in 1-2 sentences, not a section-by-section breakdown.
- Reserve tables, headers, and multi-section structure for when I ask for a comparison or a document. For most answers, a few sentences or a short list is enough.
- Explain reasoning only when I ask "why", when you're making a non-obvious tradeoff, or when flagging a risk. Otherwise state the decision and move on.
- One round of status per background task, not running commentary. Don't narrate each poll.
- Cut hedging and qualifiers. Say the thing once.

## Engineering
- Weigh quality, simplicity, robustness, scalability, and long-term maintainability over development cost.
- Bug fixes start by reproducing the bug E2E, as close to how a user hits it as possible - so the fix targets the real cause.
- Hold a high bar on lint, test failures, and flakiness. Fix one you spot even if it is not yours.
- When testing UI, be picky and obsessed with pixel perfection. If something looks off, fix it along the way.

## Code comments
- Default to none. A comment earns its place only if it says something the code cannot: the WHY, a hidden constraint, a non-obvious hazard.
- One line by default. Never multi-paragraph blocks. State the fact, not adjectives.

## Writing (docs, PRs, design notes)
- Lead with the point. The document must stand on its own without a meeting to explain it.
- Every data point needs context: baseline, comparison, or benchmark, plus a timeframe and source. State an absolute baseline behind any relative metric ("up 20%, from 100 to 120").
- Connect data to the business or customer implication - do not just list numbers.
- Pick the right visual: bar for comparing categories, line for trends over time, table for precise multi-dimension values.
- Cut weasel words. Avoid hedges (may, might, should, seems, aim to) and vague descriptors (effective, seamless, robust, streamline, great) unless backed by a specific number or example.
- Prefer specific names over vague ones, in prose and in code (PaymentProcessor, not PaymentHelper).
