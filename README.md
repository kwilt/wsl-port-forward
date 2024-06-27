# WSL2 Port Forwarding
## **Feel free to use, fork, modify.** 

At the time of writing this, you can't easily set a static IP in WSL2, and can't easily do port forwarding for whatever reason (thanks Microsoft), so you must take extra steps. These scripts intend to solve the problem without making use of scheduled tasks on Windows or any 3rd party software.

<hr>

### These scripts are meant to be used together to accomplish port forwarding to/from your Windows host and WSL2


## set-wslip.sh 
- Creates a new file `.wslip` at `C:\Users\<your account>\.wslip` and writes your WSL IP address to that file.
  - In my use, I placed this script in my VM, then added the path of the script to my `.bashrc` so the script is run automatically when starting the VM
 
## PortForward.ps1
- Uses [netsh](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh) to do port forwarding on ports 8080 and 443 (can easily change the ports via variables in the script if desired)
- Reads IP stored in `.wslip` in order to do the port forwarding
- Needs to be run as admin (most likely)
