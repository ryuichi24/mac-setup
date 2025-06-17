## vim.fn.stdpath("data") ?

The `~/.local/share/nvim` directory follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html), which is a standard used by many Linux and Unix-like systems (including macOS and WSL on Windows).

---

## 📂 Why `~/.local/share/nvim`?

When you run:

```lua
vim.fn.stdpath("data")
```

It returns the standard **data storage directory** for Neovim. According to the XDG spec:

| Path type  | Meaning                             | Neovim path           |
| ---------- | ----------------------------------- | --------------------- |
| **Config** | user config files                   | `~/.config/nvim`      |
| **Data**   | stateful/non-code plugin data, etc. | `~/.local/share/nvim` |
| **Cache**  | temporary or rebuildable files      | `~/.cache/nvim`       |

---

## 🧠 Why this separation?

This separation keeps your system organized:

- `~/.config/nvim` → Your settings (like `init.lua`)
- `~/.local/share/nvim` → Installed plugins, plugins data
- `~/.cache/nvim` → Things that can be deleted safely (compiled files, etc.)

---

## 🛠 Can you change it?

Yes. You can override the default XDG paths by setting environment variables:

```sh
export XDG_DATA_HOME="$HOME/custom-data-dir"
```

Then Neovim will use that instead of `~/.local/share`.

---
