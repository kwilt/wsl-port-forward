# wsl-port-forward
### These scripts are meant to be used together to accomplish port forwarding to/from your Windows host and WSL2

## set-wslip.sh 
- Creates a new file `.wslip` at `C:\Users\<your account>\.wslip` and writes your WSL IP address to that file.
  - In my use, I have just added the path to this file in my `.bashrc` so the script is run automatically when starting the VM
 
## PortForward.ps1
- Uses [netsh](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh) to do port forwarding on ports 8080 and 443 (can easily change the ports via variables in the script if desired)
- Reads IP stored in `.wslip` in order to do the port forwarding
