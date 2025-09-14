# System Administration Scripts

This repository contains a set of Bash scripts designed for system administration tasks on Unix-based systems (Slackware, Solaris, and other Linux distros). Below is a description of each script included in this repository.

---

## 1. `archivo_log.sh`
### Description:
This script provides a simple utility to display system logs. It is compatible with Slackware, Solaris, and other Unix-like systems. The script offers options to:
- Show the last 15 lines of system log files.
- Search for a specific word in the logs and display the relevant lines.

### Features:
- Clears the terminal screen for better visibility.
- Detects the appropriate `tail` command based on the operating system (Solaris or others).
- A menu interface to choose different actions.

### Example Usage:
```bash
bash /path/archivo_log.sh
```

## 2. `buscar_archivo.sh`
### Description:
A versatile script for searching files and counting word occurrences within files. It is compatible with Unix systems and supports:

- Searching for files by name in a directory.
- Counting occurrences of a word in a file.
- Displaying the lines where the word appears.

### Features:

- Option to search files recursively in a directory.
- Count word occurrences without using `-o` or `awk` for efficiency.
- Menu interface to perform various file operations.

### Example Usage:
```bash
bash /path/buscar_archivo.sh
```

## 3. filtrar_listar.sh
### Description:
This script lists files, directories, and symlinks in a given path and provides options to filter and sort them by different characteristics such as:

- File date (most recent/oldest).
- File size (largest to smallest).
- File type (regular file, directory, symlink).

### Features:
- Recursive and non-recursive file listing.
- Sorting based on date or size.
- Filter files by name patterns.

### Example Usage:
```bash
bash /path/filtrar_listar.sh /path/to/directory
```

## 4. n_grupo.sh
### Description:
This script creates a new group on Unix systems (Linux or Solaris). It checks whether the group already exists and creates it with a specified GID (Group ID).

### Features:

- Compatible with both Solaris and Linux systems.
- Detects the operating system and uses the appropriate command (groupadd or groupadd -g).
- Ensures that the group does not already exist before creating it.

### Example Usage:
```bash
bash /path/n_grupo.sh groupname 1001
```

## 5. n_usuarios.sh
### Description:
This script creates a new user with specific attributes, home directory, and permissions. It also allows setting permissions for the user, group, and others on the user's home directory and a public HTML directory.

### Features:
- User creation with specified description, group, shell, and home directory.
- Assigns custom permissions to the user’s home directory and public_html folder.
- Verifies if the shell exists before proceeding with user creation.

### Example Usage:
```bash
bash /path/n_usuarios.sh username group description /home/username /bin/bash 700 770 755
```

## Requirements:
- Bash shell.
- Compatible with Unix-based systems like Slackware and Solaris.