# Linux Command Line Comprehensive Cheat Sheet

## Basic System Operations

### Login and Session Management

```bash
# Login to remote system
ssh user@remote-server.com

# Switch users
su                          # Switch to root user
sudo command                # Run command as root
exit                        # Logout/exit current session
```

### System Shutdown and Reboot
```bash
sudo shutdown -h now        # Shutdown immediately
sudo shutdown -h 10:00      # Shutdown at 10:00 AM
sudo shutdown -h +10        # Shutdown in 10 minutes
sudo shutdown -r now        # Restart immediately
sudo reboot                 # Restart system
sudo halt                   # Halt system
sudo poweroff               # Power off system

# With notification message
sudo shutdown -h 10:00 "Shutting down for scheduled maintenance."
```

### Virtual Terminal Navigation
```bash
Ctrl+Alt+F1 to F6          # Switch to virtual terminals
Ctrl+Alt+F7                # Return to graphical desktop
Alt+F1 to F6               # Switch between VTs (when already in VT)
```

### Desktop Environment Control
```bash
sudo systemctl stop gdm    # Stop graphical desktop
sudo systemctl start gdm   # Start graphical desktop
sudo telinit 3             # Alternative: switch to text mode
sudo telinit 5             # Alternative: switch to graphical mode
```

## File and Directory Operations

### Directory Navigation
```bash
pwd                        # Print working directory
cd                         # Go to home directory
cd ~                       # Go to home directory
cd /                       # Go to root directory
cd ..                      # Go to parent directory
cd -                       # Go to previous directory
cd /path/to/directory      # Go to specific directory
echo $HOME                 # Show home directory path
```

### Directory History
```bash
pushd /path/to/dir         # Push directory to stack and change to it
popd                       # Pop directory from stack and change to it
dirs                       # Show directory stack
```

### Listing Files and Directories
```bash
ls                         # List files and directories
ls -l                      # Long format listing
ls -a                      # Show hidden files
ls -la                     # Long format with hidden files
ls -lh                     # Human readable file sizes
ls -R                      # Recursive listing
ls -t                      # Sort by modification time
ls -S                      # Sort by file size
```

### Creating and Removing Directories
```bash
mkdir dirname              # Create directory
mkdir -p path/to/dirname   # Create directory with parent directories
rmdir dirname              # Remove empty directory
rm -rf dirname             # Remove directory and all contents (use carefully!)
```

### File Operations
```bash
touch filename             # Create empty file or update timestamp
touch -t 12091600 file     # Set specific timestamp (Dec 9, 4 PM)
cp source dest             # Copy file
cp -r source dest          # Copy directory recursively
mv oldname newname         # Rename/move file
rm filename                # Remove file
rm -i filename             # Remove file with confirmation
rm -f filename             # Force remove file
```

## File Viewing and Content Management

### Viewing File Contents
```bash
cat filename               # Display entire file
tac filename               # Display file in reverse order
less filename              # View file with pagination
more filename              # View file with pagination (older)
head filename              # Show first 10 lines
head -n 20 filename        # Show first 20 lines
tail filename              # Show last 10 lines
tail -n 15 filename        # Show last 15 lines
tail -f filename           # Follow file changes (useful for logs)
```

### File Links
```bash
ln file1 file2             # Create hard link
ln -s file1 file3          # Create symbolic (soft) link
ls -li                     # Show inode numbers and link counts
```

## File Search and Location

### Finding Files with locate
```bash
locate filename            # Find files using database
locate zip | grep bin      # Find files with 'zip' and 'bin' in name
sudo updatedb              # Update locate database
```

### Finding Files with find
```bash
find . -name "filename"    # Find files by name in current directory
find /usr -name gcc        # Find files named 'gcc' in /usr
find /usr -type d -name gcc # Find directories named 'gcc'
find /usr -type f -name gcc # Find regular files named 'gcc'
find . -iname "*.txt"      # Case-insensitive search
find . -name "*.swp" -exec rm {} \; # Find and execute command
find . -name "*.swp" -delete # Find and delete files
```

### Finding Files by Time and Size
```bash
find . -ctime 3            # Files changed exactly 3 days ago
find . -ctime +3           # Files changed more than 3 days ago
find . -ctime -3           # Files changed less than 3 days ago
find . -atime 3            # Files accessed 3 days ago
find . -mtime 3            # Files modified 3 days ago
find . -size +10M          # Files larger than 10MB
find . -size -1k           # Files smaller than 1KB
find . -size 100c          # Files exactly 100 bytes
```

### Wildcards
```bash
ls *.txt                   # Files ending with .txt
ls file?.txt               # Files like file1.txt, fileA.txt
ls file[123].*             # Files like file1.*, file2.*, file3.*
ls file[!123].*            # Files NOT like file1.*, file2.*, file3.*
```

## Application and System Information

### Locating Programs
```bash
which program              # Show path to program
whereis program            # Show program, source, and manual locations
type command               # Show command type and location
```

### System Monitoring
```bash
ps                         # Show running processes
ps aux                     # Show all processes with details
top                        # Real-time process monitor
htop                       # Enhanced process monitor (if installed)
df -h                      # Show disk usage
du -h                      # Show directory sizes
free -h                    # Show memory usage
uptime                     # Show system uptime and load
```

## Input/Output Redirection and Pipes

### Redirection
```bash
command > file             # Redirect stdout to file (overwrite)
command >> file            # Redirect stdout to file (append)
command < file             # Use file as stdin
command 2> file            # Redirect stderr to file
command 2>&1               # Redirect stderr to stdout
command &> file            # Redirect both stdout and stderr to file
command > file 2>&1        # Alternative: redirect both to file
```

### Pipes
```bash
command1 | command2        # Pipe output of command1 to command2
command1 | command2 | command3 # Chain multiple commands
cat file | grep pattern    # Search for pattern in file
ls -l | less              # Page through long directory listing
ps aux | grep process     # Find specific process
```

## Package Management

### Debian/Ubuntu (APT)
```bash
# Update package database
sudo apt update

# Upgrade packages
sudo apt upgrade
sudo apt dist-upgrade

# Install packages
sudo apt install package-name
sudo apt install package1 package2

# Remove packages
sudo apt remove package-name
sudo apt autoremove package-name
sudo apt purge package-name

# Search packages
apt search keyword
apt-cache search keyword

# Show package information
apt show package-name
apt-cache show package-name

# List installed packages
dpkg --list
apt list --installed

# Find which package contains a file
dpkg --search filename
```

### Red Hat/CentOS/Fedora (DNF/YUM)
```bash
# Update package database and upgrade
sudo dnf update
sudo yum update  # For older systems

# Install packages
sudo dnf install package-name
sudo yum install package-name

# Remove packages
sudo dnf remove package-name
sudo yum remove package-name

# Search packages
dnf search keyword
yum search keyword

# Show package information
dnf info package-name
yum info package-name

# List installed packages
dnf list installed
rpm -qa

# Find which package contains a file
rpm -qf filename
dnf provides filename
```

### SUSE/openSUSE (Zypper)
```bash
# Update and upgrade
sudo zypper refresh
sudo zypper update

# Install packages
sudo zypper install package-name

# Remove packages
sudo zypper remove package-name

# Search packages
zypper search pattern

# Show package information
zypper info package-name
```

### Low-level Package Management
```bash
# RPM-based systems
rpm -i package.rpm         # Install package
rpm -U package.rpm         # Upgrade package
rpm -e package-name        # Remove package
rpm -qa                    # List all installed packages
rpm -qi package-name       # Show package info
rpm -ql package-name       # List package files

# Debian-based systems
sudo dpkg --install package.deb    # Install package
sudo dpkg --remove package-name    # Remove package
dpkg --list                        # List installed packages
dpkg --listfiles package-name      # List package files
```

## Text Processing and Search

### grep (Pattern Searching)
```bash
grep pattern file          # Search for pattern in file
grep -i pattern file       # Case-insensitive search
grep -r pattern directory  # Recursive search
grep -n pattern file       # Show line numbers
grep -v pattern file       # Invert match (lines without pattern)
grep -c pattern file       # Count matching lines
```

## Environment and Variables

### Environment Variables
```bash
echo $HOME                 # Show home directory
echo $PATH                 # Show command search path
echo $USER                 # Show current user
env                        # Show all environment variables
export VAR=value           # Set environment variable
unset VAR                  # Remove environment variable
```

### Command Line Prompt
```bash
echo $PS1                  # Show current prompt
PS1="\u@\h \$ "           # Set prompt to user@host $
PS1="\w \$ "              # Set prompt to current_directory $
```

## File Permissions and Ownership

### Viewing Permissions
```bash
ls -l                      # Show detailed file permissions
ls -la                     # Show permissions including hidden files
```

### Changing Permissions
```bash
chmod 755 file             # Set permissions using octal notation
chmod u+x file             # Add execute permission for owner
chmod g-w file             # Remove write permission for group
chmod o+r file             # Add read permission for others
```

### Changing Ownership
```bash
sudo chown user file       # Change file owner
sudo chown user:group file # Change owner and group
sudo chgrp group file      # Change group only
```

## Archive and Compression

### tar (Tape Archive)
```bash
tar -czf archive.tar.gz directory/    # Create compressed archive
tar -xzf archive.tar.gz               # Extract compressed archive
tar -tf archive.tar.gz                # List archive contents
tar -czf backup.tar.gz file1 file2    # Archive specific files
```

### Other Compression Tools
```bash
gzip file                  # Compress file
gunzip file.gz             # Decompress file
zip archive.zip files      # Create zip archive
unzip archive.zip          # Extract zip archive
```

## Network and Remote Operations

### Network Information
```bash
ifconfig                   # Show network interfaces (older)
ip addr show               # Show network interfaces (newer)
ping hostname              # Test network connectivity
wget url                   # Download file from web
curl url                   # Transfer data from/to servers
```

### File Transfer
```bash
scp file user@host:/path   # Copy file to remote host
scp user@host:/path file   # Copy file from remote host
rsync -av source dest      # Synchronize directories
```

## Process Management

### Managing Processes
```bash
jobs                       # Show active jobs
fg                         # Bring job to foreground
bg                         # Send job to background
nohup command &            # Run command immune to hangups
kill PID                   # Terminate process by PID
killall process-name       # Terminate all processes by name
```

### Job Control
```bash
command &                  # Run command in background
Ctrl+C                     # Interrupt current process
Ctrl+Z                     # Suspend current process
```

## File System Navigation Tree

### Viewing Directory Structure
```bash
tree                       # Show directory tree
tree -d                    # Show only directories
tree -L 2                  # Limit depth to 2 levels
tree -a                    # Show hidden files
```

## Quick Reference - Most Common Commands

### Essential Daily Commands
```bash
ls -la                     # List all files with details
cd directory               # Change directory
pwd                        # Show current location
cp source destination      # Copy files
mv old new                 # Move/rename files
rm filename                # Delete files
mkdir dirname              # Create directory
cat filename               # View file contents
grep pattern file          # Search in files
find . -name "filename"    # Find files
sudo command               # Run as administrator
man command                # Show manual for command
history                    # Show command history
clear                      # Clear terminal screen
```

## Tips and Shortcuts

### Command Line Shortcuts
```bash
Tab                        # Auto-complete commands/files
Ctrl+L                     # Clear screen
Ctrl+C                     # Cancel current command
Ctrl+D                     # Exit terminal/logout
Ctrl+R                     # Search command history
!!                         # Repeat last command
!n                         # Repeat command number n from history
!string                    # Repeat last command starting with string
```

### Getting Help
```bash
man command                # Show manual page
command --help             # Show command help
info command               # Show info page
whatis command             # Brief description
apropos keyword            # Find commands related to keyword
```

---

*This cheat sheet covers the most essential Linux command line operations. For more detailed information about any command, use `man command` to access the manual pages.*