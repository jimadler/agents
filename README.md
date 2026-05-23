# Agents

## Hermes Installation
- **On Mac Mini**
  - [Within pyenv](https://share.google/aimode/LGfVWCbwBfWuKLQEs)
  - [Google Chat Setup](https://hermes-agent.nousresearch.com/docs/user-guide/messaging/google_chat)
      - config.yaml

            platforms:
              google_chat:
                '0': hermes-google_chat

- **On Mac Desktop**
  - [Gemini API Key](https://aistudio.google.com/u/1/api-keys?pli=1&project=smart-tinkering)
      - Create API Key
          - Name your key: ``hermes-agent-1``
          - Choose an imported project: ``smart-tinkering``
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
    - ``~/.ssh/config``:

          Host 192.168.1.123	# mac mini IP
             ForwardAgent yes  
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
  - Push: ``git push -u origin main``

## Mac Mini: Out-of-the-Box Installation
- **On Mac Mini**
  - Install [iTerm2](https://iterm2.com/downloads/stable/iTerm2-3_6_10.zip) 
    - Settings > Keys > Key Bindings
      - Keyboard shortcuts: 
        - Option-Left Arrow -> Send Escape Sequence ``b``
        - Option-Right Arrow -> Send Escape Sequence ``f``
  - Shell, zhrc
  - Install Homebrew

        $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        $ echo >> /Users/jim/.zprofile
        $ echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/jim/.zprofile
        $ eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  - Install Packages
  
        $ brew install pyenv
        $ brew install pyenv-virtualenv
        
        $ pyenv install 3.14                # Google App Engine 3.14
        $ pyenv virtualenv 3.14 ha-314      # create virtual environment
        $ pyenv activate ha-314             # activate virtual environment
        $ pip install --upgrade pip         # upgrade pip in the gcp virtual environment
        
        # to deativate and uninstall environment
        $ pyenv deactivate
        $ pyenv uninstall ha-314  

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
