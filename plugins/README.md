# Plugins

## Installing

In your `.bashrc`, add the plugin:

```
plugins=(
    git
    cheat
    # add additional plugins here
)
```

## Contributing

All plugins should be self-contained. Each plugin should have the following files:

- `[plugin name].plugin.sh` - the plugin functionality
- `help` - the text to be printed when calling `plugin [plugin name] help`
- `README.md` - a README file for contributors
