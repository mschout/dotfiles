---
name: gitlab-mr-review
description: >
  GitLab MR Review
  trigger phrase:
  - GitLab MR review
  - "review MR", "review merge request"
  Input: GitLab MR URL（e.g. https://gitlab.com/group/project/-/merge_requests/123）
---

# GitLab MR Review

Automated code review workflow: parse MR URL, checkout branches, analyze diffs, perform deep review, and post inline comments via GitLab MCP.

## Workflow

### Step 1: Parse MR URL

Extract `project_path` and `merge_request_iid` from the URL.

Pattern: `https://{host}/{project_path}/-/merge_requests/{iid}`

Example:
- URL: `https://gitlab.deepwisdomai.com/solutions_general/metagpt/metagptx-backend/-/merge_requests/3141`
- project_path: `solutions_general/metagpt/metagptx-backend`
- iid: `3141`

### Step 2: Fetch MR Details

Use `mcp__gitlab__get_merge_request` to get:
- `source_branch`, `target_branch`
- `diff_refs.base_sha`, `diff_refs.head_sha`, `diff_refs.start_sha` (required for inline comments)
- `title`, `description`, `author`

```
mcp__gitlab__get_merge_request(project_id=project_path, merge_request_iid=iid)
```

### Step 3: Checkout & Diff

Run in parallel:

```bash
git fetch origin <source_branch> <target_branch>
```

Then:

```bash
git checkout <source_branch>
git log --oneline origin/<target_branch>..origin/<source_branch>
git diff origin/<target_branch>...origin/<source_branch>
```

### Step 4: Deep Code Review

For each changed file, read the full file context (not just the diff) to understand surrounding code.

Use the **Task tool with `subagent_type=Explore`** to investigate cross-cutting concerns:
- Security implications (path traversal, injection, auth bypass)
- How similar patterns are handled elsewhere in the codebase
- Whether existing utilities/validators should be reused

#### Review Checklist

Categorize findings by severity:

| Severity | Label | Criteria |
|----------|-------|----------|
| HIGH | Security, Data Loss, Critical Bug | Path traversal, injection, auth bypass, data corruption |
| MEDIUM | Authorization, Business Logic, Performance | Missing permission checks, missing validation, N+1 queries |
| LOW | Code Quality, Style, Error Handling | Dead code, naming, silent failures, missing tests |

For each finding, include:
- Severity tag and category
- Concrete description of the problem
- Code snippet showing the issue
- Suggested fix with code example (reference existing codebase patterns when possible)

### Step 5: Post Inline Comments

Use `mcp__gitlab__create_merge_request_thread` to post each finding as an
inline diff comment.  If `mcp__gitlab__create_merge_request_thread` is not
available, use `glab mr note create --file $file --line $line` instead.

Required `position` object fields from Step 2:
```json
{
  "base_sha": "<diff_refs.base_sha>",
  "head_sha": "<diff_refs.head_sha>",
  "start_sha": "<diff_refs.start_sha>",
  "position_type": "text",
  "old_path": "<file_path>",
  "new_path": "<file_path>",
  "new_line": <line_number_in_new_file>,
  "old_line": null
}
```

Key rules:
- For **added lines** (in the diff's new file): set `new_line` to the line number, `old_line` to `null`
- For **deleted lines** (in the diff's old file): set `old_line` to the line number, `new_line` to `null`
- For **unchanged context lines**: set both `old_line` and `new_line`
- `old_path` and `new_path` are the same unless the file was renamed
- Post all comments **in parallel** since they are independent

#### Comment Format

```markdown
<severity_emoji> **[<SEVERITY> - <Category>] <Title>**

<Description of the problem>

<Code snippet or reference>

**<Suggestion label>** <Fix with code example>
```

Severity emoji mapping: HIGH = `🔴`, MEDIUM = `🟡`, LOW = `🟢`

### Step 6: Summary

After posting all comments, output a summary table:

```markdown
| # | File | Line | Severity | Issue |
|---|------|------|----------|-------|
| 1 | path/to/file.py:123 | HIGH | Description |
| ... |
```

Include the MR web URL for reference.
