# Agents

## Contents
- [Hermes Installation](#hermes-installation)
- [Remote IntelliJ Development](#remote-intellij-development)
- [Utilities](#utilities)
  - [Mac Mini: Out-of-the-Box Installation](#mac-mini-out-of-the-box-installation)

## Hermes Installation 
- **On Mac Mini**
  1. Download: ``$ curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash``
  1. Quick Setup
     - Provider: [Google AI Studio Setup](https://hermes-agent.nousresearch.com/docs/user-guide/providers/google_ai_studio)
       - [Gemini API Key](https://aistudio.google.com/u/1/api-keys?pli=1&project=smart-tinkering)
           - Create API Key
               - Name your key: ``hermes-agent-1``
               - Choose an imported project: ``smart-tinkering``
           - Store in ``investments/code/smart_tinkering/credentials/google-ai-studio-smart-tinkering.json``
           - Copy/Paste ``GOOGLE_API_KEY`` or add to ``~.hermes/.env``  
       - Messaging Setup with [Google Chat](https://hermes-agent.nousresearch.com/docs/user-guide/messaging/google_chat)
         - ``.hermes/.env``:

               # Google Chat
               GOOGLE_CHAT_PROJECT_ID=smart-tinkering
               GOOGLE_CHAT_SUBSCRIPTION_NAME=projects/smart-tinkering/subscriptions/hermes-chat-events-sub
               GOOGLE_CHAT_SERVICE_ACCOUNT_JSON=/Users/jim/.hermes/google-chat.smart-tinkering.service.json
               GOOGLE_CHAT_ALLOWED_USERS=jim@jimadler.me
        
               # Google Chat, optional
               GOOGLE_CHAT_HOME_CHANNEL=spaces/AAAA...         # default delivery destination for cron jobs
               GOOGLE_CHAT_MAX_MESSAGES=1                      # Pub/Sub FlowControl; 1 serializes commands per session
               GOOGLE_CHAT_MAX_BYTES=16777216                  # 16 MiB — cap on in-flight message bytes
 
         - [Fix Google Chat Permissions](https://github.com/NousResearch/hermes-agent/issues/22947)
           - For ``hermes-chat-events`` ``Pub/Sub Publisher`` permission, DO NOT USE ``chat-api-push@system.gserviceaccount.com`` 
           - Instead, use ``service-<project-related-id>@gcp-sa-gsuiteaddons.iam.gserviceaccount.com``
             - For ``smart-tinkering``, ``project-related-id`` = ``538130621360`` (see [Compute Engine default service account](https://console.cloud.google.com/iam-admin/iam?authuser=1&project=smart-tinkering))
         - Install python dependencies

               $ source ~/.hermes/hermes-agent/.venv/bin/activate
               $ uv pip install --python ~/.hermes/hermes-agent/venv/ google-cloud-pubsub google-api-python-client google-auth google-auth-oauthlib
               $ hermes gateway restart

## Remote IntelliJ Development
- **Remote Development**
  - **On Mac Mini** 
    - Enable Remote Login
      - Settings > General > Sharing > Remote Login
    - Prevent Sleep: 
      - Settings > Lock Screen > Turn display off when inactive: ``Never``
    - IP Address: 
      - Wi-Fi > Details > TCP/IP > IP Address (e.g., 192.168.1.123)
  - **Mac Desktop**
    - Start [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
      - Go to ``SSH`` context (top right)
        - New Connection: ``jim@192.168.1.123``
        - ``Create``
      - ``192.168.1.123`` > Hamburger menu > Open remote server
        - Open ``IntelliJ IDEA``
        - ``Clone Repository``
          - URL: ``git@github.com:jimadler/agents.git`` > ``Clone``
            - ``Forward SSH credentials``

## Utilities
- **SSH Setup**
  - Generate Keys: ``ssh-keygen -t ed25519 -C "jims-mac-mini@jimadler.me"``
  - Login: 
      
        $ ssh jim@192.168.1.123
        $ Are you sure you want to continue connecting (yes/no/[fingerprint])? <yes>

- **Git**
  - To use SSH for Git operations (cloning, pushing, pulling), set up your SSH keys on Mac Mini:
    1. Generate SSH Key: ``ssh-keygen -t ed25519 -C "github-jims-mac-mini@jimadler.me"``
    1. [Add Key to GitHub](https://github.com/settings/keys) 
    1. Enable SSH in IntelliJ: In the Version Control > GitHub settings, check the box Clone git repositories using ssh.

  - Push: ``git push -u origin main``

## Mac Mini: Out-of-the-Box Installation
- **On Mac Mini**
  - Install [iTerm2](https://iterm2.com/downloads/stable/iTerm2-3_6_10.zip) 
    - Settings > Keys > Key Bindings
      - Keyboard shortcuts: 
        - Option-Left Arrow -> Send Escape Sequence ``b``
        - Option-Right Arrow -> Send Escape Sequence ``f``
  - Install Homebrew

        $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        $ echo >> /Users/jim/.zprofile
        $ echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/jim/.zprofile
        $ eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  - Install Python 3.14
 
        $ brew search python
        $ brew install python@3.14
        $ brew link --overwrite --force python@3.14
  - Install virtual environment

        $ brew install pyenv
        $ brew install pyenv-virtualenv
  - Modify shell: ``~/.zshrc`` and ``~/.zprofile`` (see agents/shell)

- **Remote Connections**
  - Mac Mini (IP: 173.3.185.207)
  - On Mac Mini, ``System Settings > Screen Sharing``
    1. Screen Sharing: ``On``
    1. Anyone may request permission to control screen: ``On``
    1. Password: ``<password>``

  - For connections from local networks
    1. On Mac Mini:
       1. Copy ``Sharing > Local hostname``
    1. On Mac Desktop:
       1. Open Screen Sharing.app, ``Connection > New...``

              Connect To: <Local hostname>  # jims-mac-mini.local

  - For connections from non-local networks
    1. On Mac Mini:
        1. Install ngrok

                brew install ngrok/ngrok/ngrok
        1. Configure ngrok with authtoken from [ngrok dashboard](https://dashboard.ngrok.com/get-started/your-authtoken)

                ngrok config add-authtoken <ngrok authtoken>
        1. Start TCP terminal
    
                ngrok tcp 5900
        1. Copy ``TCP address``
    1. On Mac Desktop:
       1. ``System Settings > General > Sharing > Screen Sharing``

                VNC viewers may control screen with password
                Password: <password>
                Allow access for: <Administrators>

       1. Open Screen Sharing.app, ``Connection > New...``
   
               Connect To: <TCP address>  # 4.tcp.us-cal-1.ngrok.io:15803
