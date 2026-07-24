#!/usr/bin/env pwsh
# monitor-ci.ps1 â€” Polls GitHub Actions CI/CD pipeline and handles failures

param(
    [string]$Repo = "<owner/repo>",
    [string]$Branch = "main",
    [int]$PollInterval = 30,
    [int]$MaxWait = 600  # 10 minutes
)

Write-Host "Monitoring CI/CD pipeline for $Repo on branch $Branch..."

# Get the latest run
$runJson = gh run list --repo $Repo --branch $Branch --limit 1 --json databaseId | ConvertFrom-Json
if (-not $runJson -or $runJson.Count -eq 0) {
    Write-Error "No runs found for $Repo/$Branch"
    exit 1
}
$runId = $runJson[0].databaseId
Write-Host "Found run ID: $runId"

$elapsed = 0
while ($true) {
    $runView = gh run view $runId --repo $Repo --json status,conclusion | ConvertFrom-Json
    $status = $runView.status
    $conclusion = $runView.conclusion

    if ($status -eq "completed") {
        break
    }

    if ($elapsed -ge $MaxWait) {
        Write-Error "Pipeline stuck in '$status' for over $MaxWait seconds. Runner may be offline."
        exit 1
    }

    Write-Host "Pipeline status: $status (${elapsed}s elapsed)"
    Start-Sleep -Seconds $PollInterval
    $elapsed += $PollInterval
}

if ($conclusion -eq "success") {
    Write-Host "Pipeline succeeded."
    # Run production smoke tests if target is reachable
    if (Test-Connection "<production-ip>" -Count 1 -Quiet) {
        Write-Host "Running production smoke tests..."
        npx playwright test --config=e2e/playwright.production.config.ts
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Production smoke tests failed."
            exit 1
        }
    } else {
        Write-Host "Production target unreachable; skipping local smoke tests (relying on CI smoke stage)."
    }
    Write-Host "Deployment verified successfully."
    exit 0
} else {
    Write-Error "Pipeline failed."
    gh run view $runId --repo $Repo --log-failed
    exit 1
}