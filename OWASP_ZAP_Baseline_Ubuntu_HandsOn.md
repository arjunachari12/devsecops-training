# OWASP ZAP Baseline – Hands-On Lab (Ubuntu)

This document provides step-by-step instructions to set up **OWASP Juice Shop** and run **OWASP ZAP Baseline scans** on **Ubuntu**.
It is designed for **DevSecOps training** and assumes **no developer background**.

---

## 1. Prerequisites

- Ubuntu 20.04 or later  
- Docker installed and running  
- Internet access to pull Docker images  
- Basic terminal knowledge  

---

## 2. Lab Objective

By the end of this lab, participants will:

- Understand what a **DAST baseline scan** is  
- Run OWASP Juice Shop as a vulnerable application  
- Execute OWASP ZAP Baseline scan safely  
- Interpret ZAP scan reports  
- Relate findings to **OWASP Top 10**

---

## 3. Step 1: Run OWASP Juice Shop (Target Application)

OWASP Juice Shop is an intentionally vulnerable web application used for security training.

### Run Juice Shop
```bash
docker run -d --name juice-shop -p 3000:3000 bkimminich/juice-shop
```

### Verify Application
Open in browser:
```
http://localhost:3000
```

---

## 4. Step 2: Create Directory for ZAP Reports

Create a directory to store scan reports:

```bash
mkdir zap-reports
```

---

## 5. Step 3: Run OWASP ZAP Baseline Scan

Run the OWASP ZAP Baseline scan using Docker.  
This is a **passive scan** and safe for CI/CD pipelines.

```bash
docker run --rm \
  -v $(pwd)/zap-reports:/zap/wrk \
  -t owasp/zap2docker-stable \
  zap-baseline.py \
  -t http://172.17.0.1:3000 \
  -r zap-report.html
```

### What this does
- Passive scan only (no attacks)
- Observes HTTP traffic
- Generates an HTML report

---

## 6. Step 4: View the ZAP Report

After the scan completes, open the report:

```bash
xdg-open zap-reports/zap-report.html
```

The report shows security alerts categorized by severity.

---

## 7. Common Findings Explained (Trainer Notes)

- **Content-Security-Policy Header Missing**  
  Increases risk of Cross-Site Scripting (XSS)

- **X-Frame-Options Missing**  
  Application is vulnerable to clickjacking

- **Cookie Without HttpOnly Flag**  
  Session cookies can be stolen via JavaScript

- **Information Disclosure**  
  Sensitive system details exposed

---

## 8. Exercises

### Exercise 1: Identify Security Headers
- Open the ZAP report
- List all missing security headers  
**Question:** Which OWASP Top 10 category do they map to?

---

### Exercise 2: Cookie Security Analysis
- Identify cookies without `HttpOnly` or `Secure` flags  
**Question:** What attack becomes possible due to this?

---

### Exercise 3: Severity Understanding
- Count the number of Medium and Low alerts  
**Question:** Why are there no High alerts in baseline scan?

---

### Exercise 4: Pipeline Failure Simulation
Re-run the scan and fail on Medium severity:

```bash
docker run --rm \
  -v $(pwd)/zap-reports:/zap/wrk \
  -t owasp/zap2docker-stable \
  zap-baseline.py \
  -t http://172.17.0.1:3000 \
  -m 2
```

Observe the exit code.

---

### Exercise 5: Conceptual Fix Discussion
Discuss how missing headers or cookie flags can be fixed.  
(No code changes required.)

---

## 9. Cleanup

Stop and remove Juice Shop container:

```bash
docker stop juice-shop
docker rm juice-shop
```

---

## 10. Key Takeaways

- ZAP Baseline is safe for DevSecOps pipelines  
- Focuses on **security hygiene**, not exploitation  
- Ideal for early detection of misconfigurations  
- Complements SAST and SCA tools  
