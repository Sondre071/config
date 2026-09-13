# My config stuff

## NuShell

```shell
scoop install nu
```

To allow native invocation and skip the `nu` keyword, run this within Administrator Command Prompt:

```cmd
assoc .nu=NushellScript
ftype NushellScript="C:\Path\To\Your\nu.exe" "%1" %*
```

## psmux

```shell
scoop bucket add psmux https://github.com/psmux/scoop-psmux
scoop install psmux
```
