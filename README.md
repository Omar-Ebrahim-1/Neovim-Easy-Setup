# TODO: Update README
## Install & Configure Plugins
1.  Put in ~/.config/nvim/lua/arch/packer.lua

    ```lua
    use('Github_username/Github_plugin_name')
    ```
2. Open repo and look for default config options e.g: `M.default_opts`
3. Put in a new lua file at ~/.config/nvim/after/plugin/ to override default
   config
    ```lua
    require('plugin_name').setup{
        config_var1 = new_value1
        config_var2 = {
                config_var2_1 = new_value2_1
                config_var2_2 = new_value2_2
            }
    }
    ```
## Remaps & Sets
- Put new remaps in ~/.config/nvim/lua/arch/remap.lua
- Put new sets in ~/.config/nvim/lua/arch/set.lua
