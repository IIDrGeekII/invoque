# invoque

Invoque is a simple bash script to execute multiple commands on multiple devices. It's basically a linux based script used solely when there is requirement wherein we need to take the output of certain commands from multiple devices.

On normal occasion, we take the access of device, execute the command, take the output and then repeat this process for other device.

Using this script, one can automate this process by taking access of one device and using this script you can take output from multiple devices using *SSHPASS* & *SSH*.

Just make sure all the devices can be access using ssh command from a single device.

Use can use this script to run any command on a well known devices like Firewalls (with linux shell like *Checkpoint*), *Cisco ACI*, Load Balancers (*like F5 LB*), *Linux Servers* or *OS*.


Instructions before you run this script:

```
This script will help to invoke multiple commands on multiple devices.

  1. Make sure the credentials you are providing are present on all the devices on which you want to execute the command.

  2. You can use TACACS+ or AD credentials as well for access the devices if local login is not permitted.

  3. Provide exact and correct command to execute.

  4. If not sure the command provided is correct then first try the command on a single device and then use this script.

  5. While using grep with command use "-E" flag to search multiple words at a time like: grep -E "word1|word2".

  6. If for any reason you make a typo and need to exit use CTRL+C.
```

> **Note:**
```
1. You can provide either IP address or hostname as input to take ssh access of the device.
2. After running the script, it executes the input command and saves the output to a .txt file.
3. It will then create a folder with name "invoque" in the current directory.

```

# Walkthrough

![image](https://github.com/IIDrGeekII/invoque/assets/75925433/957ec816-9143-435d-8c3c-54058b55bb5b)

**Easy Command:**

![image](https://github.com/IIDrGeekII/invoque/assets/75925433/bc825222-0871-4d89-b822-ab63c423bae2)

**Complex Command:**

![image](https://github.com/IIDrGeekII/invoque/assets/75925433/da3dbf03-d368-41e4-8e9f-6f3ecf5f5e50)

**Sample command output format in file:**

![image](https://github.com/IIDrGeekII/invoque/assets/75925433/a157250d-c180-487a-af84-e93a90a82148)


To execute this program, follow these steps:

```
    1. Open a terminal of linux based device.
    
    2. Save the program to a file with a ".sh" extension.
    
    3. Set the file's permissions to allow execution by running the command "chmod +x invoque.sh".
    
    4. Run the program by entering "./invoque.sh" in the terminal
    
    5. Follow the prompts and enter any required inputs.
    
    6. The program will execute the selected function and provide the result.
```






