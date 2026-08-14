---
name: clipboard-suggestions
description: >-
  ALWAYS use this skill when suggesting text the user should paste, post, send,
  submit, or add somewhere. This includes review replies, PR or issue comments,
  Slack messages, emails, descriptions, announcements, commands, and other
  ready-to-use text. Prompt the user to copy the suggestion to their clipboard.
---

# Clipboard Suggestions

When producing ready-to-use text for the user:

1. Draft the exact text without surrounding commentary.
2. Use `ask_user` to show the draft and ask whether to copy it to the clipboard.
3. If accepted, copy the exact draft with:

   ```bash
   printf '%s' '<text>' | pbcopy
   ```

4. Confirm briefly that it was copied.

Do not copy automatically. Do not include Markdown fences, labels, or
explanations in the clipboard unless the user asks for them.

If there are multiple distinct drafts, ask about them one at a time.
