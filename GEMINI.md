# User Preferences & Instructions

## Documentation Workflow
Every time a system configuration or keybinding is changed, always create or update a documentation file in `/home/ngl/Documents/obsidian git sync/obsidian/900 System/omarchymyway/`.
- Use a numbered prefix (e.g., `01-`, `02-`).
- Include a GitHub-style `diff` showing the old and new code.
- Include a "How to Revert" section.
- Explain the reason for the change clearly.

## Git Workflow
If working within a git repository, every time a change is made to the code, automatically perform a git commit for those changes.
- Do NOT wait for a separate instruction to commit.
- Use concise, descriptive commit messages based on the change.

## Command Execution
Before executing ANY shell command (even simple ones like `ls` or `grep`), you MUST first output a conversational text message explaining exactly what the command does and why you are running it.
- This applies to 100% of shell commands. NO EXCEPTIONS.
- NEVER rely solely on the tool's internal `description` parameter.
- The explanation MUST be sent as a normal chat message so the user can read it *before* the execution prompt blocks the screen.
- Format the explanation clearly: "I am about to run: `[command]`. This will: [impact]."



