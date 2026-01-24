# GitGuardian (ggshield) – Hands-on Step-by-Step Lab (Ubuntu Compatible)

## Objective
This hands-on lab helps participants understand how GitGuardian (ggshield) prevents secret leaks at the developer and CI/CD level as part of DevSecOps shift-left security.

---

## Pre-requisites
- Ubuntu laptop / VM with internet access
- Git installed
- Python 3.x installed
- GitHub/GitLab account (only for signup, no repo access required)
- Free GitGuardian account

---

## Step 0: Create a GitGuardian Account (Mandatory)

`ggshield` requires a GitGuardian account to function.

### Steps
1. Open https://www.gitguardian.com
2. Sign up using GitHub, GitLab, or Email
3. Choose the **Free plan** (sufficient for training)
4. No credit card is required

### Notes
- This account is only your identity on GitGuardian
- No repositories are accessed at this stage

---

## Step 1: Install ggshield on Ubuntu

Install `ggshield` using `pip` (recommended for Ubuntu):

```bash
python3 -m pip install --user ggshield
```

Add pip binaries to PATH:

```bash
export PATH=$PATH:$HOME/.local/bin
```

Verify installation:

```bash
ggshield --version
```

---

## Step 2: Authenticate ggshield (What `auth login` Does)

Run the authentication command:

```bash
ggshield auth login
```

### What Happens
- A browser window opens
- You log in using your GitGuardian account
- An API token is generated and stored locally
- No source code is uploaded during login

### Token Storage Location (Ubuntu)
```text
~/.config/ggshield/config.yaml
```

---

## Step 3: Create a Sample Git Repository

Create a demo repository:

```bash
mkdir ggshield-demo
cd ggshield-demo
git init
```

Create a file with a fake secret:

```bash
echo "AWS_ACCESS_KEY_ID=AKIA1234567890TEST" > secrets.txt
```

---

## Step 4: Scan Repository for Secrets

Run a repository scan:

```bash
ggshield secret scan repo .
```

### Expected Result
- Secret is detected
- ggshield explains the secret type
- Remediation guidance is shown

---

## Step 5: Enable Pre-Commit Protection

Install the pre-commit hook:

```bash
ggshield secret install pre-commit
```

Test commit blocking:

```bash
git add secrets.txt
git commit -m "test secret"
```

### Expected Result
- Commit is blocked
- Clear error message is shown

---

## Step 6: Remediation Best Practices
- Never commit secrets to Git
- Rotate exposed credentials immediately
- Use secret managers (Azure Key Vault, AWS Secrets Manager)
- Use environment variables and secure references

---

## Trainer Talking Points
- `ggshield` requires authentication because it is SaaS-backed
- Only secret fingerprints are sent, not full code
- Gitleaks and GitGuardian complement each other

---

## Expected Outcome
After this lab, participants will understand:
- Why secrets leakage is dangerous
- How ggshield authentication works
- How pre-commit prevention blocks secrets
- How this fits into DevSecOps shift-left security
