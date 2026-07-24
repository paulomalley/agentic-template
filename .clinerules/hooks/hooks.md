---

## Hooks (Automatic Event Triggers)

Hooks are executable scripts that trigger at specific workflow events. They reside in `.clinerules/hooks/`.

**Note:** This file is documentation. Actual hook scripts must be executable files (e.g., `.sh` on Unix, `.ps1` on Windows) placed in this directory with the appropriate naming convention for the hook framework in use.

**Windows note:** Bash-based hooks (like the example below) will not execute natively on Windows. On Windows, either use PowerShell equivalents or run via WSL/Git Bash if available.

### Example: `.clinerules/hooks/PostToolUse`

```bash
#!/usr/bin/env bash
# PostToolUse hook — runs after Cline completes a tool call
# Receives JSON via stdin, returns JSON controlling whether to proceed

input=$(cat)

# Check if the tool was apply_patch or write_to_file
tool_name=$(echo "$input" | jq -r '.toolName // ""')

# If the tool edited files, check if any were in boundary paths
if [[ "$tool_name" == "apply_patch" || "$tool_name" == "write_to_file" ]]; then
    file_path=$(echo "$input" | jq -r '.params.filePath // .params.path // ""')

    if [[ "$file_path" =~ ^client/ ]] || [[ "$file_path" =~ ^server/src/routes/ ]]; then
        echo "Running smoke tests due to change in $file_path..." >&2
        if npm run test:smoke; then
            echo '{"cancel": false, "contextModification": "Smoke tests passed."}'
        else
            echo '{"cancel": false, "contextModification": "WARNING: Smoke tests failed. Please review the output above."}'
        fi
        exit 0
    fi
fi

# Default: allow the operation to proceed
echo '{"cancel": false}'
```

**Integration with testing skill:** When this hook fires on a boundary-path change, it should also trigger the `testing` skill review (see `.clinerules/skills/testing/SKILL.md`).