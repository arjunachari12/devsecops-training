# Exercise: A02 – Cryptographic Failures (OWASP Juice Shop)

## Objective
Understand how improper use of cryptography and poor handling of sensitive data can lead to data exposure, account compromise, and system breaches.

---

## Background
Cryptographic Failures occur when applications fail to properly protect sensitive data. This may be due to missing encryption, weak cryptographic algorithms, poor key management, or exposing sensitive information where it should not be available.

OWASP Juice Shop intentionally demonstrates these failures to highlight real-world risks.

---

## Prerequisites
- OWASP Juice Shop running locally using Docker  
- Application accessible at `http://localhost:3000`  
- Web browser with Developer Tools (Chrome / Firefox)

---

## Scenario 1: Sensitive Data Exposure via JWT Token

### Description
OWASP Juice Shop stores authentication information in a JSON Web Token (JWT) on the client side. JWTs are **signed but not encrypted**, meaning their contents are readable by anyone who has access to the token.

### Steps
1. Register a new user account in OWASP Juice Shop.
2. Log in using the newly created account.
3. Open **Browser Developer Tools (F12)**.
4. Navigate to **Application → Local Storage → http://localhost:3000**.
5. Copy the value that starts with `eyJ...` (JWT token).
6. Paste the token into:
   ```
   https://jwt.io
   ```
   to decode it.

### Expected Observation
The decoded JWT payload reveals sensitive user information such as:
- Email address
- Password hash
- User role
- Account status

This information is visible to the client and can be stolen if the token is compromised.

### Why This Is a Cryptographic Failure
- JWTs are Base64 encoded, **not encrypted**
- Sensitive data should never be included in client-side tokens
- Storing tokens in Local Storage exposes them to **XSS attacks**
- Exposure of cryptographic material nullifies encryption protections

---

## Scenario 2: Insecure Transmission of Credentials (No TLS)

### Description
OWASP Juice Shop runs over HTTP by default, meaning credentials and tokens are transmitted without encryption.

### Steps
1. Access the application using:
   ```
   http://localhost:3000
   ```
2. Open **Developer Tools → Network** tab.
3. Log in or register a user.
4. Inspect the request payload and headers.

### Expected Observation
Login credentials and tokens are visible in clear text within network requests, making them vulnerable to interception.

---

## Scenario 3: Weak Password Recovery Mechanism

### Description
Weak account recovery mechanisms can undermine strong cryptography by allowing attackers to bypass authentication entirely.

### Steps
1. Navigate to **Login → Forgot Password**.
2. Enter a registered email address.
3. Observe the security question presented.
4. Attempt to guess or brute-force the answer.

### Expected Observation
Predictable security questions and lack of rate limiting make account recovery insecure.

---

## How to Fix Cryptographic Failures (Best Practices)
- Enforce **HTTPS (TLS)** for all communications
- Use strong password hashing algorithms (**bcrypt, Argon2**)
- Never expose sensitive data in JWTs or client-side storage
- Store authentication tokens in **HttpOnly, Secure cookies**
- Use secure, token-based password recovery mechanisms

---

## Key Takeaways
Cryptography is only effective when used correctly. Strong algorithms cannot protect data if secrets, tokens, or sensitive information are exposed due to poor design or implementation.
