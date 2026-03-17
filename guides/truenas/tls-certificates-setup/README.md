# TrueNAS – TLS Certificates Setup

This tutorial provides a step-by-step guide on how to set up a **Let's Encrypt TLS certificate** on **TrueNAS SCALE**
using **Cloudflare** as the DNS provider. The setup uses the **DNS-01 challenge**, meaning Cloudflare handles domain
verification entirely via DNS records — no ports need to be opened on your router

> **SSL vs TLS:** SSL is the outdated predecessor to TLS and has been cryptographically broken for decades — everything
> today uses TLS. The term "SSL certificate" persists only as a colloquial legacy name. TrueNAS still uses "SSL" in
> some UI labels, but the certificates it issues and uses are TLS

## Prerequisites

Before starting, ensure you have the following ready:

- A **registered domain name** with its DNS management moved to **Cloudflare** (this is free and may take up to 24 hours
  to propagate)
- An **email address** in your TrueNAS root (or admin) profile that matches your Cloudflare account email

## Setup

### 1: Create a Cloudflare API Token

1. Log in to your **Cloudflare dashboard**, go to your profile, and select **API Tokens**
2. Choose **Create Custom Token**
3. Set the following **Permissions**:
    - **Zone / Zone / Read**
    - **Zone / DNS / Edit**
4. Click **Continue to summary**, then **Create Token** and **copy the generated token**

### 2: Configure the DNS Authenticator in TrueNAS

1. In the TrueNAS web interface, navigate to **Credentials > Certificates**
2. Go to the **DNS Authenticators** section and click **Add**
3. Give it a name (e.g., "Cloudflare-Authenticator") and select **Cloudflare** as the provider
4. Paste the **API Token** you created in Step 1 into the token field and click **Save**

### 3: Create a Certificate Signing Request (CSR)

1. Under **Certificate Signing Requests**, click **Add**
2. Enter a name for the CSR (this is just a label for your own reference) and select **Create Certificate Signing
   Request**
3. Fill in the geographical details: **Country** (e.g., Ukraine), **State** (Kyiv), **Locality** (Kyiv), and
   **Organization** — these fields are required by the CSR form but are not validated or used by Let's Encrypt
4. **Crucial:** In the **Email** field, enter the email address used for both your Cloudflare and TrueNAS accounts —
   Let's Encrypt uses this for expiry notifications and ties it to your ACME account
5. In the **Common Name** field, enter your domain name (e.g., `example.com`)
6. In the **Subject Alternative Names** field, enter a wildcard for your domain (e.g., `*.example.com`) so the
   certificate covers all subdomains
7. Click **Next** and **Save**

### 4: Issue the TLS Certificate via Let's Encrypt

1. Locate your new CSR and click the **wrench icon** (setup) next to it
2. Give the certificate a name (e.g., "my-domain-cert")
3. Set the **Renewal days** — Let's Encrypt certificates are valid for 90 days; a 30-day renewal window is the
   standard recommendation, giving enough time to catch failures before expiry
4. Select **Let's Encrypt Production** as the ACME directory
5. Select the **Cloudflare DNS Authenticator** you created in Step 2
6. Click **Save** — this process may take 1–2 minutes while the certificate is issued

### 5: Apply the Certificate to the Web Interface

1. Go to **System Settings > General**
2. Click **Settings** (or Edit) in the GUI section
3. In the **GUI SSL Certificate** dropdown, change "default" to the name of the certificate you just created
4. (Optional) You can enable a redirect from HTTP to HTTPS, though the source cautions this may affect some apps
5. Click **Save** and confirm the **Web Interface reload**

### 6: Verification

To verify, attempt to access your TrueNAS interface via your subdomain using **https://**. Your browser should now show
a **secure connection icon**, and the certificate details should confirm it was issued by **Let's Encrypt**. The
certificate will now automatically renew every 30 days

## Materials

### YouTube

- [Create a Let’s Encrypt certificate on TrueNAS SCALE](https://youtu.be/CFD4LhXah48?si=nGPeG6iit1hdGGo1)
