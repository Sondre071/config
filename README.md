# All my configs

## How to use

Run `init.nu` using NuShell

## Prerequisites

### Developer mode

Turn on _developer mode_ within Windows System Settings to allow the script to create symlinks.

### Install NuShell

```shell
scoop install nu
```

### Enable NuShell easy file invocation

To skip the `nu` keyword and inject env config, run this within Administrator Command Prompt:

```cmd
assoc .nu=NushellScript
ftype NushellScript="C:\Path\To\nu.exe" --env-config "C:\Path\To\env.nu" "%1" %*
```

nu.exe is found by running:
`which nu`

config path is found by running:
`$nu.config-path`


### NeoVim config path

Set the environment variable `XDG_CONFIG_HOME` to the config directory.

### Install psmux

```shell
scoop bucket add psmux https://github.com/psmux/scoop-psmux
scoop install psmux
```
