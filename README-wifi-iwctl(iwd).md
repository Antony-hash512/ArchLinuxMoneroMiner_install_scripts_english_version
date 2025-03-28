**`iwd`** (iNet wireless daemon) is a modern console utility for managing Wi-Fi on Linux, which can work as an alternative to **`wpa_supplicant`**. To connect to Wi-Fi using **iwd**, you need to follow several steps to connect to Wi-Fi from the Arch boot ISO where NetworkManager is not available.

### Steps to connect to Wi-Fi through **iwd**:

1. **Starting the iwd service**:

   First, make sure that the **iwd** service is running:

   ```bash
   sudo systemctl start iwd
   ```

   If you want the service to start automatically at boot, activate it:

   ```bash
   sudo systemctl enable iwd
   ```

2. **Starting the `iwctl` utility**:

   To connect to Wi-Fi, use the **`iwctl`** utility, which comes with **iwd**. Start it:

   ```bash
   sudo iwctl
   ```

   Inside this interface, you will enter commands to manage Wi-Fi connections.

3. **Checking available interfaces**:

   To see the list of wireless interfaces, run the command:

   ```bash
   device list
   ```

   You will see a list of available interfaces. This will usually be something like **`wlan0`**.

4. **Scanning for available networks**:

   Now you can scan for available Wi-Fi networks:

   ```bash
   station wlan0 scan
   ```

   (Replace **`wlan0`** with the name of your interface if it's different).

5. **Viewing available networks**:

   After scanning, you can see a list of available networks:

   ```bash
   station wlan0 get-networks
   ```

6. **Connecting to a network**:

   To connect to a network, run the command:

   ```bash
   station wlan0 connect <SSID>
   ```

   Replace **`<SSID>`** with the name of the Wi-Fi network you want to connect to. If the network is password-protected, you will be prompted to enter the password.

7. **Checking the connection**:

   After connecting, you can check the status of your connection:

   ```bash
   station wlan0 show
   ```

   If everything went well, you will see information about the connection.

8. **Exiting iwctl**:

   To exit the **`iwctl`** utility, simply run:

   ```bash
   exit
   ```

### Configuring IP using `dhclient` (if NetworkManager or systemd-networkd is not used):

If **`NetworkManager`** or **`systemd-networkd`** are not managing network connections, you may need to manually request an IP address via **DHCP**:

```bash
sudo dhclient wlan0
```

After this, an IP address should be assigned.

### Additional commands:

- **Disconnecting from a network**:

   If you want to disconnect from the current network, use:

   ```bash
   station wlan0 disconnect
   ```

- **Viewing current connections**:

   Command to view the status:

   ```bash
   station wlan0 show
   ```

### Installing **iwd** (if not installed):

If **iwd** is not installed, it can be installed via **pacman**:

```bash
sudo pacman -S iwd
```

### Summary:

1. Start **iwd** and the **iwctl** utility.
2. Use **iwctl** to scan for available networks and connect.
3. Enter the password if the network is protected.
4. Check the connection using **station wlan0 show**.

This way, you can connect to Wi-Fi from the console using **iwd**.
