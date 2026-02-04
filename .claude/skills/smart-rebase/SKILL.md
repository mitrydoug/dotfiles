---
name: smart-rebase
description: Prepares the current branch for code review by organizing changes into logical commits.
---

Only invoke this skill if explicitly directed by the user, or if the user asks for help preparing their branch for code review.

Do the following:
- Commit any outstanding changes into a single commit. Use prefix "WIP: " if appropriate.
- Determine the appropriate base of the smart rebase. If the current branch is the subject of an open pull request, use the base of that pull request (in the case of ambiguity, confirm with the user). If no such pull requests exist, use the default branch of the repo.
- Create a mirror branch `<current-branch>-cc-smart-rebase` (where `<current-branch>` is the name of the user's current branch).
- Reconstruct the commit history on the mirror branch by interactively rebasing onto the determined base. Split, reorder, combine, and edit commits as necessary to create a clean, logical history that is easy to review.
- Important: check that the resulting branch matches the original branch exactly (empty git diff).
- Provide a summary to the user. If there are any structural issues that need to be addressed before the branch can be reviewed, clearly outline these issues and suggest next steps.

Notes:
- When splitting commits, aim to create logical units of change that are easy to review.
- Ensure that each commit has a clear, descriptive message that accurately reflects the changes made.
  - if a commit is particularly complex, consider adding more detail to its message.
- try to group business logic changes with their related tests.