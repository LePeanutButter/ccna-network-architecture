# System Administration Scripts

This folder contains a collection of Bash scripts designed to automate system administration tasks, primarily for **Unix/Linux** systems. These scripts focus on tasks such as log management, user/group management, file searching, and directory operations, all of which are essential for efficient system administration.

The scripts are compatible with various Unix-like systems, including **Slackware, Solaris,** and other Linux distributions.

---

## Operating System Configuration, Shell, and Network Support Software

This section covers work related to system administration, virtualization, and networking practices, with a focus on both Unix/Linux and Windows environments.

### 1. `system-log-viewer.sh`

#### Description:

This script provides a simple utility to display system logs. It is compatible with Slackware, Solaris, and other Unix-like systems. The script offers options to:

- Show the last 15 lines of system log files.
- Search for a specific word in the logs and display the relevant lines.

#### Features:

- Clears the terminal screen for better visibility.
- Detects the appropriate `tail` command based on the operating system (Solaris or others).
- A menu interface to choose different actions.

#### Example Usage:

```bash
bash /path/system-log-viewer.sh
```

### 2. `file-inspector.sh`

#### Description:

A versatile script for searching files and counting word occurrences within files. It is compatible with Unix systems and supports:

- Searching for files by name in a directory.
- Counting occurrences of a word in a file.
- Displaying the lines where the word appears.

#### Features:

- Option to search files recursively in a directory.
- Count word occurrences without using `-o` or `awk` for efficiency.
- Menu interface to perform various file operations.

#### Example Usage:

```bash
bash /path/file-inspector.sh
```

### 3. `directory-inspector.sh`

#### Description:

This script lists files, directories, and symlinks in a given path and provides options to filter and sort them by different characteristics such as:

- File date (most recent/oldest).
- File size (largest to smallest).
- File type (regular file, directory, symlink).

#### Features:

- Recursive and non-recursive file listing.
- Sorting based on date or size.
- Filter files by name patterns.

#### Example Usage:

```bash
bash /path/directory-inspector.sh /path/to/directory
```

### 4. `create-group.sh`

#### Description:

This script creates a new group on Unix systems (Linux or Solaris). It checks whether the group already exists and creates it with a specified GID (Group ID).

#### Features:

- Compatible with both Solaris and Linux systems.
- Detects the operating system and uses the appropriate command (groupadd or groupadd -g).
- Ensures that the group does not already exist before creating it.

#### Example Usage:

```bash
bash /path/create-group.sh groupname 1001
```

### 5. `create-user.sh`

#### Description:

This script creates a new user with specific attributes, home directory, and permissions. It also allows setting permissions for the user, group, and others on the user's home directory and a public HTML directory.

#### Features:

- User creation with specified description, group, shell, and home directory.
- Assigns custom permissions to the user’s home directory and public_html folder.
- Verifies if the shell exists before proceeding with user creation.

#### Example Usage:

```bash
bash /path/create-user.sh username group description /home/username /bin/bash 700 770 755
```

---

## DNS Services Configuration and Task Automation Through Scripting in Virtualized Environments

### 1. `task-scheduler.sh`

#### Description:

This script automates the addition of a **cron job** to the current user's crontab, ensuring that **duplicate entries are avoided**. It simplifies task scheduling by validating input and safely updating the crontab.

#### Features:

- Accepts a single cron job line as input (e.g., `* * * * * /path/to/script.sh`).
- Validates the format to ensure it contains at least six fields (schedule + command).
- Checks the current crontab for duplicates before adding the new entry.
- Creates a temporary crontab file for safe editing.
- Automatically cleans up temporary files.
- Provides helpful logging and error messages.
- Supports help flags `-h` and `--help`.

#### Example Usage:

```bash
bash /path/task-scheduler.sh "* * * * * /home/user/backup.sh"
```

This command adds a cron job that runs `/home/user/backup.sh` every minute, unless it’s already present in the user's crontab.

### 2. `process-manager.sh`

#### Description:

An interactive Bash script that provides a **menu-driven interface** for managing system processes. It supports listing, searching, killing, and restarting processes across various Unix-like systems including **Linux, Solaris, BSD, and macOS**.

#### Features:

- **Cross-platform compatibility**: Automatically detects the operating system and selects the appropriate `ps` command format.
- **Interactive menu**: Offers a user-friendly interface to perform process management tasks.
- **Robust error handling**: Uses traps and validation to prevent crashes and handle invalid input gracefully.
- **Logging**: Timestamps all actions for better traceability.

#### Menu Options:

1. **List all processes**  
   Displays all running processes with their PID, command name, CPU usage (%), and memory usage (%).

2. **Search for a process**  
   Allows searching for a process by name or pattern using case-insensitive matching.

3. **Kill a process**  
   Terminates a process by its PID after validating the input.

4. **Restart a process**  
   Gracefully restarts a process by:

   - Capturing its full command line.
   - Killing the process.
   - Relaunching it in the background.

5. **Exit**  
   Safely exits the script.

#### Example Usage:

```bash
bash /path/process-manager.sh
```

To view help:

```bash
bash /path/process-manager.sh --help
```

### 3. `smallest-files-finder.sh`

#### Description:

This script scans the current directory and its subdirectories to identify the **N smallest files** whose sizes do not exceed a specified maximum size. It outputs a neatly formatted list showing:

- Filename
- Full path
- Size in bytes

#### Features:

- Validates input arguments for file count and size limit.
- Supports size suffixes: `K`, `M`, `G` (e.g., `10MB`, `500K`).
- Uses POSIX-compliant utilities for compatibility across Unix-like systems.
- Filters readable files only and excludes inaccessible ones.
- Sorts results by file size in ascending order.
- Displays results in reverse order (smallest last) for better visibility.

#### Example Usage:

```bash
bash /path/smallest-files-finder.sh 10 1MB
```

This command finds the 10 smallest readable files under 1MB in the current directory tree.

---

### Requirements:

- Bash shell.
- Compatible with Unix-based systems like Slackware and Solaris.
