# Hands-On Lab: Gitleaks on Ubuntu (Native Installation)

## Lab Objectives
- Install Gitleaks natively on Ubuntu (without Docker)
- Run secret scans against OWASP Juice Shop
- Scan Git history for leaked secrets
- Learn important Gitleaks commands and sub-commands

---

## Prerequisites
- Ubuntu 20.04 / 22.04
- Internet access
- Git installed
- sudo privileges

---

## Step 1: Install Required Packages
```bash
sudo apt update
sudo apt install -y git wget tar
```

---

## Step 2: Download Gitleaks
```bash
cd /tmp
wget https://github.com/gitleaks/gitleaks/releases/latest/download/gitleaks-linux-amd64.tar.gz
```

---

## Step 3: Install Gitleaks
```bash
tar -xvf gitleaks-linux-amd64.tar.gz
sudo mv gitleaks /usr/local/bin/
sudo chmod +x /usr/local/bin/gitleaks
```

---

## Step 4: Verify Installation
```bash
gitleaks version
```

---

## Step 5: Clone OWASP Juice Shop
```bash
git clone https://github.com/juice-shop/juice-shop.git
cd juice-shop
```

---

## Step 6: Create a Fake Secret (Intentional)
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

## Step 7: Commit the Secret
```bash
git add .
git commit -m "Added secrets file"
```

---

## Step 8: Run Gitleaks Scan (Repository)
```bash
gitleaks detect
```

---

## Step 9: Scan Full Git History
```bash
gitleaks detect --log-opts="--all"
```

---

## Step 10: Run Verbose Scan
```bash
gitleaks detect --verbose
```

---

## Step 11: Generate JSON Report
```bash
gitleaks detect --report-format json --report-path gitleaks-report.json
```

---

## Step 12: Fix the Issue
```bash
rm -rf config/secrets.js
echo "config/secrets.js" >> .gitignore
git add .
git commit -m "Removed hardcoded secrets"
```

---

## Step 13: Re-run Gitleaks
```bash
gitleaks detect
```

---

## Important Gitleaks Commands

| Command | Description |
|-------|-------------|
| `gitleaks detect` | Scan current repository |
| `gitleaks detect --source <dir>` | Scan a directory |
| `gitleaks detect --log-opts="--all"` | Scan entire Git history |
| `gitleaks detect --verbose` | Detailed output |
| `gitleaks detect --report-format json --report-path file.json` | Generate CI/CD report |
| `gitleaks version` | Show installed version |
| `gitleaks help` | Show all commands |

---

## Key Learning Outcomes
- Secrets must never be committed to Git
- Git history retains leaked secrets
- Gitleaks should run before pushing to GitHub
- Pre-commit hooks and CI/CD enforcement are critical

---

### Trainer Note
> One leaked secret can compromise an entire cloud account.  
> Gitleaks is a preventive control, not a detective afterthought.
