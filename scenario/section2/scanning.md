# Secrets Scanning with Infisical

This guide walks you through setting up Infisical for secrets scanning in your repository.

## Prerequisites

1. **Create Infisical Account**
   - Sign up for a free account at [infisical.com](https://infisical.com) 

2. **Install Infisical CLI**
   - Follow the installation guide: [CLI Overview](https://infisical.com/docs/cli/overview)

## Basic Scanning

3. **Run Initial Scan**
   ```bash
   infisical scan
   ```

   To see detailed findings:
   ```bash
   infisical scan --verbose
   ```

   you can see the difference: --verbose will explain more which file is not secure

   ![local scan Infisical](infisical-local-scan.png)
   
## Pre-commit Hooks

4. **Enable Pre-commit Scanning**
   
   Install the pre-commit hook to automatically scan before commits:
   ```bash
   infisical scan install --pre-commit-hook
   ```
   
    It should show a success message like this
    ![pre-commit-hook](pre-commit-hook.png) 

   To disable the hook:
   ```bash
   git config --bool hooks.infisical-scan false
   ```

## GitHub Actions Integration

5. **Setup GitHub Actions**
   - {{steps for github action}}
   - {{scope of this to check when pushed to main, and PR to main}}

    ```
    name: secret-scanning

    on:
    push:
        branches:
        - main
    pull_request:
        branches:
        - main    
    jobs:
    secret-scanning:
        runs-on: ubuntu-22.04
        steps:
        - name: checkout repository
            uses: actions/checkout@v5

        # Infiscal CLI
        # TODO: Set a specific version
        - name: install Infiscal CLI
            run: |
            curl -1sLf \
            'https://artifacts-cli.infisical.com/setup.deb.sh' \
            | sudo -E bash
            sudo apt-get update && sudo apt-get install -y infisical

        # exit code 1 if secret is found
        - name: run secret scanning
            run: |
            infisical scan --verbose --report-path secret-scanning-report.json

        # print the scan results (no matter the exit code)
        - name: print scan results
            if: always()
            run: |
            cat secret-scanning-report.json
    ```

## Next Steps

6. **Verify Setup**
   - Test the pre-commit hook by making a commit
   - Check that GitHub Actions runs the secret scanning workflow
   - Review any findings and remediate as needed

   ((expand on verify steps. also maybe we should split the sections so its not too long?))