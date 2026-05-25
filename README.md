# Agents

## Contents
- [Hermes Skills](#hermes-skills)
- [Hermes Local Models](#hermes-local-models)
- [Hermes Installation](#hermes-installation)
- [OpenCode](#opencode)
- [Remote IntelliJ Development](#remote-intellij-development)
- [Mac Mini: Out-of-the-Box Installation](#mac-mini-out-of-the-box-installation)
- [Utilities](#utilities)

**General Notes** 
- All operations on Mac Mini unless otherwise stated

## Hermes Skills
- [Command List](https://hermes-agent.nousresearch.com/docs/reference/slash-commands) or ``/commands`` from chat

      /reset    - new session
      /skills   - doesn't work on chat w/ Qwen
      $  hermes skills list
- For custom skills, external directory
  - ~/.hermes/config.yaml

        skills:
          external_dirs:
            - /path/to/your/git-repo/my-hermes-skills
            - ${SKILLS_REPO}/custom-skills

## Hermes Local Models
- Download [ollama](https://ollama.com/search)

      $ curl -fsSL https://ollama.com/install.sh | sh

- Pull the models

      $ ollama pull qwen2.5:7b
      $ ollama pull deepseek-r1:8b
      $ ollama pull gemma2:9b

- Terminal Permissions
  - System Settings > Privacy & Security
    - Accessibility: Add ``<terminal apps>`` that launched Hermes
    - Full Disk Access: Add ```<terminal apps>``` that launched Hermes
- Configure Hermes to run both models.
  - ~/.zshrc
    
        export OLLAMA_KEEP_ALIVE="0"
  - ~/.hermes/config.yaml

        # Primary Model: Handles initial chat, fast formatting, and tool-calling scripts
        model:
          provider: custom
          model: qwen2.5:7b     # gemma2:9b
          context_length: 65536
          ollama_num_ctx: 65536
          base_url: "http://127.0.0.1:11434/v1"
 
        # Fallback Model Layer: Activates if Qwen hits capacity limits, errors out,
        # or fails an algorithmic execution threshold.
        fallback_model:
          provider: custom
          model: deepseek-r1:8b
          context_length: 65536
          ollama_num_ctx: 65536
          base_url: "http://127.0.0.1:11434/v1"

        auxiliary:
          compression:
            provider: custom
            model: qwen2.5:7b
            base_url: "http://127.0.0"
            context_length: 65536

- Gemma4 Tool Hack
  - Result: Can't host Gemma4 locally due to (1) XML tool incompatibility with Hermes and (2) large local context. 
  - Solution: Use OpenRouter free or go back to Qwen
    - config.yaml for OpenRouter
        
          model:
            provider: "openrouter"
            model: "google/gemma-4-31b-it:free"  # <--- Points to the 100% free cloud tier
             context_length: 65536

  - History
    - Gemma4's tool-calling capabilities are currently suboptimal. To deal with it:
     
          $ ollama create gemma4-json -f ~/Projects/agents/hermes/gemma4/model_file
    - Add to config.yaml

          model:
            provider: custom
            model: gemma-json:latest
            context_length: 65536
            ollama_num_ctx: 65536
            base_url: "http://127.0.0"
            api_key: "none"

## Hermes Installation
- Download: ``$ curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash``
- Provider Setup
  - Provider: [Google AI Studio Setup](https://hermes-agent.nousresearch.com/docs/user-guide/providers/google_ai_studio)
  - [Gemini API Key](https://aistudio.google.com/u/1/api-keys?pli=1&project=smart-tinkering)
    - Create API Key
      - Name your key: ``hermes-agent-1``
      - Choose an imported project: ``smart-tinkering``
    - Store in ``investments/code/smart_tinkering/credentials/google-ai-studio-smart-tinkering.json``
    - Copy/Paste ``GOOGLE_API_KEY`` or add to ``~.hermes/.env``
- Gateway Setup
  - Discord ([instructions](https://hermes-agent.nousresearch.com/docs/user-guide/messaging/discord))
    - [Discord Agent App](https://discord.com/developers/applications/1508518228543148102/installation) 
  - Telegram
    1. Create the Telegram bot
      1. Go to Telegram App
      1. Search for ``@BotFather``: ``/newbot`` and follow prompts
         1. Name: ``HermesAgent_ce6e_bot``
            - Bot Token: ``investments/credentials/telegram-hermes-bot.json``
            - Link: ``t.me/HermesAgent_ce6e_bot``
            - Help (image, etc): ``/help``
            - Change Username: Ping Bot Support 
            - Bot API: https://core.telegram.org/bots/api
    1. Get numeric Telegram User ID
      1. In Telegram, search for ``@userinfobot``
      1. Send any message to ```@HermesAgent_ce6e_bot```
         - Response: ``@jim_adler``, ``Id: 6230436353``
    1. Add Telegram to Hermes
      1. ``.hermes/.env``
      2. Add the following variables:

             TELEGRAM_BOT_TOKEN=<Bot Token>
             TELEGRAM_ALLOWED_USER_IDS=6230436353  # @jim_adler
             TELEGRAM_HOME_CHANNEL=6230436353
      3. Restart gateway: ``hermes gateway start``
    1. Pair and Test
      1. In Telegram, search for the ``@HermesAgent_ce6e_bot``
      1. Click ``Start``. The bot will give you a pairing command or code.
      1. Paste that command into your Hermes terminal to approve your Telegram account as an authorized user

  - Google Chat
    1. ``.hermes/.env``

           # Google Chat
           GOOGLE_CHAT_PROJECT_ID=smart-tinkering
           GOOGLE_CHAT_SUBSCRIPTION_NAME=projects/smart-tinkering/subscriptions/hermes-chat-events-sub
           GOOGLE_CHAT_SERVICE_ACCOUNT_JSON=/Users/jim/.hermes/google-chat.smart-tinkering.service.json
           GOOGLE_CHAT_ALLOWED_USERS=jim@jimadler.me
        
           # Google Chat, optional
           GOOGLE_CHAT_HOME_CHANNEL=spaces/AAAA...         # default delivery destination for cron jobs
           GOOGLE_CHAT_MAX_MESSAGES=1                      # Pub/Sub FlowControl; 1 serializes commands per session
           GOOGLE_CHAT_MAX_BYTES=16777216                  # 16 MiB — cap on in-flight message bytes
 
    1. [Fix Google Chat Permissions](https://github.com/NousResearch/hermes-agent/issues/22947)
       - For ``hermes-chat-events`` ``Pub/Sub Publisher`` permission, DO NOT USE ``chat-api-push@system.gserviceaccount.com`` 
       - Instead, use ``service-<project-related-id>@gcp-sa-gsuiteaddons.iam.gserviceaccount.com``
         - For ``smart-tinkering``, ``project-related-id`` = ``538130621360`` (see [Compute Engine default service account](https://console.cloud.google.com/iam-admin/iam?authuser=1&project=smart-tinkering))
    1. Install python dependencies

           $ source ~/.hermes/hermes-agent/venv/bin/activate
           $ uv pip install --python ~/.hermes/hermes-agent/venv/ google-cloud-pubsub google-api-python-client google-auth google-auth-oauthlib
           $ hermes gateway restart
  - Voice Setup
      1. Install voice capabilities:

             $ brew install portaudio ffmpeg opus
             $ brew install espeak-ng   # for NeuTTS
             $ uv pip install --python ~/.hermes/hermes-agent/venv/ hermes-agent[voice] hermes-agent[messaging] hermes-agent[tts-premium]
             $ uv pip install --python ~/.hermes/hermes-agent/venv/ neutts[all]
             $ uv pip install --python ~/.hermes/hermes-agent/venv/ faster-whisper
      1. Choosing a Local Whisper STT Model Size
          -  tiny, base, small (<1GB), medium, large, large-v3-turbo (1.6GB), large-v3 (3GB)
      1. Choosing an Edge TTS Voice Style
          - en-US-AriaNeural: Female, American accent (Standard, bright, and articulate).
          - en-US-GuyNeural: Male, American accent (Deep, clear conversational tone).
          - en-GB-SoniaNeural: Female, British accent (Polite and corporate).
          - en-GB-RyanNeural: Male, British accent (Warm and authoritative).
          - en-AU-NatashaNeural: Female, Australian accent (Casual and friendly).
      1. ``.hermes/config.yaml``

             stt:
               enabled: true
               provider: "local"
             local:
               model: "large-v3-turbo" # "small" or "large-v3-turbo" speed vs precision

             tts:
               provider: "edge"
               edge:
                 voice: "en-US-AriaNeural"
      1. Restart gateway: ``hermes gateway start``
      1. In Telegram, use ``/voice`` to enable and disable

- Custom Directories
  - Custom Skills
    - Make sure custom skills are uniquely named
    - config.yaml

          skills:
            external_dirs:
              - ~/Projects/agents/hermes/skills

  - Custom Scripts
    - Add symbolic link
    
          $ ln -s ~/Projects/agents/hermes/scripts ~/.hermes/scripts/custom

- Utilities
  - Restart
  
        $ pkill -f hermes && hermes gateway start

## OpenCode
- Install OpenCode

      $ brew install tmux
      $ brew install anomalyco/tap/opencode
      $ opencode auth login
      $ opencode
- ~/.config/opencode/opencode.jsonc

      {
        "$schema": "https://opencode.ai/config.json",
        "mcp": {
          "hermes": {
            "type": "local",
            "command": ["hermes", "mcp", "serve"]
          }
        },
        "provider": {
          "ollama": {
            "npm": "@ai-sdk/openai-compatible",
            "name": "Ollama (local)",
            "options": {
              "baseURL": "http://127.0.0.1:11434/v1"
            },
            "models": {
              "qwen3.5:4b": {
                "name": "Qwen 3.5 4B (local)",
                "limit": {
                  "context": 131072,
                  "output": 8192
                }
              }
            }
          }
        }
      }
- ~/.hermes/config.yaml

      delegation:
        model: qwen3-coder-480b  # or your preferred OpenCode Go model
        provider: custom
        base_url: https://opencode.ai/v1
        api_key: ''  # or set CUSTOM_DELEGATION_API_KEY in .env
        api_mode: chat_completions
        inherit_mcp_toolsets: true
        max_iterations: 50
        child_timeout_seconds: 600
        max_concurrent_children: 3
        max_spawn_depth: 1
        orchestrator_enabled: true
        subagent_auto_approve: false
        reasoning_effort: ''
- Restart Hermes gateway

      $ pkill -f hermes && hermes gateway start

- **Prompts**
  - "Delegate this refactoring to a subagent."
  - "Use the delegate tool to write the unit tests for this module."
  - "Spawn a subagent to implement the authentication flow."

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

## Mac Mini: Out-of-the-Box Installation
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

