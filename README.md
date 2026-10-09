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

To allow native invocation and skip the `nu` keyword, run this within Administrator Command Prompt:

```cmd
assoc .nu=NushellScript
ftype NushellScript="C:\Path\To\Your\nu.exe" "%1" %*
```

### NeoVim config path

Set the environment variable `XDG_CONFIG_HOME` to: `C:/.../.config`

### Install psmux

```shell
scoop bucket add psmux https://github.com/psmux/scoop-psmux
scoop install psmux
```
