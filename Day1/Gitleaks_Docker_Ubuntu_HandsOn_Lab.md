# Hands-On Lab: Gitleaks on Ubuntu (Docker-Based)

## Lab Objectives
- Run Gitleaks using Docker (no local installation issues)
- Scan OWASP Juice Shop for leaked secrets
- Scan full Git history
- Generate reports suitable for CI/CD
- Understand key Gitleaks commands

---

## Why Docker?
Using Docker avoids:
- Binary compatibility issues
- Package installation failures
- OS-specific dependencies

This is the recommended approach for training and CI/CD.

---

## Prerequisites
- Ubuntu 20.04 / 22.04
- Docker installed and running
- Git installed
- Internet access

Verify:
```bash
docker --version
git --version
```

---

## Step 1: Clone OWASP Juice Shop
```bash
git clone https://github.com/juice-shop/juice-shop.git
cd juice-shop
```

---

## Step 2: Create a Fake Secret (Intentional)
```bash
mkdir config
nano config/secrets.js
```

Add:
```js
module.exports = {
  jwtSecret: "mySuperSecretJWTKey12345",
  dbPassword: "P@ssw0rd123!"
};
```

---

## Step 3: Commit the Secret (Simulated Mistake)
```bash
git add .
git commit -m "Added secrets file"
```

---

## Step 4: Pull Gitleaks Docker Image
```bash
docker pull zricethezav/gitleaks
```

---

## Step 5: Run Gitleaks Scan (Repository)
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo
```

---

## Step 6: Scan Full Git History
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo --log-opts="--all"
```

---

## Step 7: Verbose Scan
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo --verbose
```

---

## Step 8: Generate JSON Report
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect   --source /repo   --report-format json   --report-path /repo/gitleaks-report.json
```

Verify:
```bash
ls gitleaks-report.json
```

---

## Step 9: Fix the Issue
```bash
rm -rf config/secrets.js
echo "config/secrets.js" >> .gitignore
git add .
git commit -m "Removed hardcoded secrets"
```

---

## Step 10: Re-run Gitleaks
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo
```

---

## Important Gitleaks Docker Commands

| Command | Description |
|------|------------|
| `docker pull zricethezav/gitleaks` | Pull image |
| `detect` | Run secret scan |
| `--source /repo` | Directory inside container |
| `--log-opts="--all"` | Scan full Git history |
| `--verbose` | Detailed output |
| `--report-format json` | CI/CD reports |

---

## Optional: Pre-Commit Hook Using Docker
```bash
nano .git/hooks/pre-commit
```

```sh
#!/bin/sh
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo || exit 1
```

```bash
chmod +x .git/hooks/pre-commit
```

---

## Key Learning Outcomes
- Docker avoids install issues
- Secrets in Git are critical risks
- Git history keeps leaked secrets
- Pre-commit and CI/CD are mandatory

---

### Trainer Note
> One leaked secret can compromise an entire cloud account.
