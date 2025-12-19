# Hands-On Lab: Gitleaks on Ubuntu (Docker-Based – Verified & Reliable)

> **Recommended approach:** Use Docker.  
> Native Ubuntu installation can break due to changing release asset names.

---

## Lab Objectives
- Run Gitleaks using Docker (no installation issues)
- Scan OWASP Juice Shop for leaked secrets
- Scan full Git history
- Generate CI/CD-friendly reports
- Learn important Gitleaks commands

---

## Why Docker?
Using Docker avoids:
- Broken or renamed GitHub release assets
- Binary / architecture mismatch
- Package manager limitations on Ubuntu

This is the **most reliable and trainer-recommended approach**.

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

## Step 4: Pull Gitleaks Docker Image (Verified)
```bash
docker pull zricethezav/gitleaks
```

---

## Step 5: Run Gitleaks Scan (Repository)
```bash
docker run --rm -v $(pwd):/repo zricethezav/gitleaks detect --source /repo
```

---

## Step 6: Scan Full Git History (Critical)
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
| `docker pull zricethezav/gitleaks` | Pull official image |
| `detect` | Run secret scan |
| `--source /repo` | Directory inside container |
| `--log-opts="--all"` | Scan entire Git history |
| `--verbose` | Detailed findings |
| `--report-format json` | Generate CI/CD report |

---

## Optional: Pre-Commit Hook (Docker-Based)

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

## Why Native Ubuntu Install Often Fails

Many guides reference:
```bash
wget https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64.tar.gz
```

❌ This often fails because:
- Asset names change per release
- `latest/download` does not always expose a generic Linux file

✔ Docker avoids this problem entirely.

---

## Key Learning Outcomes
- Docker is the safest way to run security tools
- Secrets in Git are critical risks
- Git history makes leaks permanent
- Pre-commit + CI/CD = real prevention

---

### Trainer Note
> If secrets reach GitHub, security has already failed.
