To connect to Wi-Fi in TTY, if `NetworkManager` is installed, you can use the `nmcli` command. Here's a step-by-step guide:

1. **Find available networks:**
   ```bash
   nmcli device wifi list
   ```
   This command will show a list of available Wi-Fi networks.

2. **Connect to a Wi-Fi network:**
   ```bash
   nmcli device wifi connect "SSID" password "PASSWORD"
   ```
   Replace `"SSID"` with the name of your Wi-Fi network, and `"PASSWORD"` with the network password.

   For example:
   ```bash
   nmcli device wifi connect "MyNetwork" password "SuperSecretPassword"
   ```

3. **Check connection status:**
   After executing the command, you can check if you've connected successfully using the command:
   ```bash
   nmcli connection show --active
   ```
   If you see a connection with type `wifi`, it means the connection has been established successfully.

These commands should work in any terminal, including TTY, if `NetworkManager` is installed and running.
