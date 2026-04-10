# Social Login Setup Guide

This plugin supports **Facebook**, **Google**, **Kakao**, and **Naver** login.

---

## Configuring Credentials

### Option 1: Discourse Admin UI (recommended)

1. Log into your Discourse as an **admin**
2. Go to **Admin** > **Settings** (or visit `https://YOUR_DOMAIN/admin/site_settings`)
3. Search for the provider name (e.g. "kakao", "naver", "facebook", "google")
4. For each provider:
   - Check the **enable** toggle (e.g. `kakao_login_enabled`)
   - Paste in the **client ID** and **client secret**
   - Click **Save**

The login buttons will appear on your login page immediately after saving.

### Option 2: `app.yml` (Docker-based Discourse)

If your Discourse runs via Docker (most production installs), you can set them as environment variables.

1. SSH into your server
2. Edit `/var/discourse/containers/app.yml`
3. Under the `env:` section, add:

```yaml
env:
  # Facebook
  DISCOURSE_FACEBOOK_LOGIN_ENABLED: true
  DISCOURSE_FACEBOOK_APP_ID: "your_facebook_app_id"
  DISCOURSE_FACEBOOK_APP_SECRET: "your_facebook_app_secret"

  # Google
  DISCOURSE_GOOGLE_LOGIN_ENABLED: true
  DISCOURSE_GOOGLE_CLIENT_ID: "your_google_client_id"
  DISCOURSE_GOOGLE_CLIENT_SECRET: "your_google_client_secret"

  # Kakao
  DISCOURSE_KAKAO_LOGIN_ENABLED: true
  DISCOURSE_KAKAO_CLIENT_ID: "your_kakao_rest_api_key"
  DISCOURSE_KAKAO_CLIENT_SECRET: "your_kakao_client_secret"

  # Naver
  DISCOURSE_NAVER_LOGIN_ENABLED: true
  DISCOURSE_NAVER_CLIENT_ID: "your_naver_client_id"
  DISCOURSE_NAVER_CLIENT_SECRET: "your_naver_client_secret"
```

4. Rebuild the container:

```bash
cd /var/discourse
./launcher rebuild app
```

---

## Getting the Keys

### Facebook

1. Go to https://developers.facebook.com/
2. **Create App** > Choose "Consumer" type
3. Add the **Facebook Login** product
4. Go to **Settings** > **Basic**
5. Copy **App ID** and **App Secret**
6. In Facebook Login > Settings, add redirect URI: `https://YOUR_DOMAIN/auth/facebook/callback`

**Settings to configure:**

| Setting | Value |
|---------|-------|
| `facebook_login_enabled` | `true` |
| `facebook_app_id` | Your App ID |
| `facebook_app_secret` | Your App Secret |

### Google

1. Go to https://console.cloud.google.com/
2. Create a project (or select existing)
3. Go to **APIs & Services** > **Credentials**
4. Click **Create Credentials** > **OAuth 2.0 Client ID**
5. Application type: **Web application**
6. Add authorized redirect URI: `https://YOUR_DOMAIN/auth/google_oauth2/callback`
7. Copy **Client ID** and **Client Secret**

**Settings to configure:**

| Setting | Value |
|---------|-------|
| `google_login_enabled` | `true` |
| `google_client_id` | Your Client ID |
| `google_client_secret` | Your Client Secret |

### Kakao

1. Go to https://developers.kakao.com/
2. **Create Application**
3. Go to **App Keys** — copy the **REST API Key** (this is your `client_id`)
4. Go to **Security** tab — generate and copy the **Client Secret**
5. Go to **Kakao Login** > **Redirect URI** — add: `https://YOUR_DOMAIN/auth/kakao/callback`
6. Under **Consent Items**, enable **email** and **profile**

**Settings to configure:**

| Setting | Value |
|---------|-------|
| `kakao_login_enabled` | `true` |
| `kakao_client_id` | Your REST API Key |
| `kakao_client_secret` | Your Client Secret |

### Naver

1. Go to https://developers.naver.com/
2. **Application** > **Register Application**
3. Select **Naver Login** API
4. Choose permissions: **email**, **profile name**, **profile image**
5. Set Service URL: `https://YOUR_DOMAIN`
6. Set Callback URL: `https://YOUR_DOMAIN/auth/naver/callback`
7. Copy **Client ID** and **Client Secret**

**Settings to configure:**

| Setting | Value |
|---------|-------|
| `naver_login_enabled` | `true` |
| `naver_client_id` | Your Client ID |
| `naver_client_secret` | Your Client Secret |

---

## Redirect URIs Summary

Register these callback URLs in each provider's developer console:

| Provider | Redirect URI |
|----------|-------------|
| Facebook | `https://YOUR_DOMAIN/auth/facebook/callback` |
| Google | `https://YOUR_DOMAIN/auth/google_oauth2/callback` |
| Kakao | `https://YOUR_DOMAIN/auth/kakao/callback` |
| Naver | `https://YOUR_DOMAIN/auth/naver/callback` |

Replace `YOUR_DOMAIN` with your actual Discourse domain.
