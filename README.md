# ShellSecInstall

## Prerequis
 * Internet access
 * Root access
 * Wget
 * Unzip
 * Git
	
## Instruction 
 * Install security tools in /opt 
 * chmod 765 shellSecInstall 
 * ./schellSecInstall

## Add a tools to listTools :
### Add a git :
```sh
git:nameTool:gitAdresse
```

### Add a release :
```sh
wget:nameTool:releaseAdresse
```

### Add an apt packet :
```sh
apt:nameTool:aptPacketName
```

### Add specific process : 
```sh
 Install:nameTool:install+nameTools 
```
 * Make a function named install+nameTools
 * Code process


