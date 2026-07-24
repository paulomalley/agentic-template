# CLI Execution Safety

1. PAGER AVOIDANCE: All git commands must use `--no-pager` to prevent interactive pagers from hanging the terminal (e.g. `git --no-pager log --oneline -5`, `git --no-pager diff HEAD~1 --stat`, `git --no-pager status --short`, `git --no-pager show HEAD`).
2. LARGE OUTPUT: For commands producing more than ~100 lines of output, prefer piping to `head -100` or redirecting to a file rather than unbounded terminal output.
3. DEV SERVER PRE-FLIGHT: Before starting a dev/watch server, check for stale processes from a previous session on the relevant port/binary and kill them to prevent port conflicts and resource leaks (e.g. on Windows: `tasklist /FI "IMAGENAME eq node.exe" /FO CSV` then `taskkill /F /IM node.exe` for a Node project; adapt to the actual runtime).
4. COMMAND CHAINING (shell-conditional): At the start of a session, check the default shell in system information.
   - **pwsh/powershell**: confirm version with `$PSVersionTable.PSVersion`.
     - PowerShell 7+ (Major â‰¥ 7): `&&`/`||` chaining permitted for tightly-coupled, low-risk sequences (e.g. `cd dir && npm test`).
     - PowerShell 5.1 (Major = 5) or unknown/unconfirmed: never chain, one command per tool call.
   - **cmd.exe**: script chaining via `&&` supported for tightly-coupled, low-risk sequences; no version check needed.
   - **bash/zsh**: `&&`/`||` chaining supported for tightly-coupled, low-risk sequences.
   - Regardless of shell or version, destructive commands (`rm`, `git reset --hard`, process kills, force-push) always get their own call, never chained.
   - If a chained command unexpectedly fails with a parse error, fall back to one-command-per-call for the rest of the session.