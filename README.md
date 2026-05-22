# Agents

## Hermes Development
- **On Mac Mini**
  - On Terminal:
  
        curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
- **Remote Development**
  - **On Mac Mini** 
  - Install [IntelliJ Toolbox App](https://www.jetbrains.com/toolbox-app/) for remote development (supports MacOS)
  - Enable Remote Login: ``Settings > General > Sharing > Remote Login``
  - Prevent Sleep: ``Settings > Lock Screen > Turn display off when inactive: <Never>``
  - Mac Mini IP Address: ``Wi-Fi > Details > TCP/IP > IP Address`` (192.168.1.123)
  - Mac Desktop
    - Install [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/)
    - Go to ``SSH`` context (top right)
      - New Connection: ``jim@192.168.1.123``

- **SSH Setup**
  - Generate Keys: ``ssh-keygen -t ed25519 -C "jims-mac-mini@jimadler.me"``
  - Login: 
      
        $ ssh jim@192.168.1.123
        $ Are you sure you want to continue connecting (yes/no/[fingerprint])? <yes>


## Mac Mini: Out-of-the-Box Installation
- **Install Homebrew**

        # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # echo >> /Users/jim/.zprofile
        # echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/jim/.zprofile
        # eval "$(/opt/homebrew/bin/brew shellenv zsh)"

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
