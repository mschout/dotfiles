# dotfiles

These are my dotfiles.  There are many like them but these are mine.

I'm using [yadm](https://github.com/yadm-dev/yadm) to manage these.

## Installation

```yaml
  Arch:
    yay -Syu yadm
    yadm clone https://github.com/mschout/dotfiles.git
```

## Updates
This repository is regurlarly being updated. To update to the latest version of my dotfiles, run:
```bash
yadm pull
```

## Errors

### When cloning

If you encounter any error when cloning, run 

```bash
yadm stash
```

Then reclone with 

```
yadm clone -f https://github.com/mschout/dotfiles.git
```
