local M = {}
---@class ManpackPluginSpec
---@field config? function
---@field branch? string
---@field event? string|string[]
---@field filetype? string|string[]
---@field build? function

---@param plugin_name string
---@param spec? ManpackPluginSpec
function M.load(plugin_name, spec)
    spec = spec or {}
    local plugin = "https://github.com/" .. plugin_name
    local manpackpath = vim.fn.stdpath("data") .. "/manpack"
    local plugin_dir = manpackpath .. "/" .. vim.fs.basename(plugin_name)

    if not vim.uv.fs_stat(plugin_dir) then
        local cmd = { "git", "clone", "--depth=1" }
        if spec and spec.branch then
            table.insert(cmd, "--branch=" .. spec.branch)
        end

        table.insert(cmd, plugin)
        table.insert(cmd, plugin_dir)

        local result = vim.fn.system(cmd)
        if vim.v.shell_error ~= 0 then
            print("Error al clonar el repositorio: " .. result)
        else
            print("Repositorio clonado exitosamente.")
            vim.opt.runtimepath:append(plugin_dir)
            if spec.build then
                spec.build()
            end
        end
    else
        vim.opt.runtimepath:append(plugin_dir)
    end

    local doc_dir = plugin_dir .. "/doc"
    if vim.uv.fs_stat(doc_dir) then
        vim.cmd.helptags(doc_dir)
    end

    if spec.config then
        if spec.filetype then
            vim.api.nvim_create_autocmd("FileType", {
                pattern = type(spec.filetype) == "string" and { spec.filetype } or spec.filetype,
                once = true,
                group = vim.api.nvim_create_augroup(vim.fs.basename(plugin_name) .. "-start", { clear = true }),
                desc = "Starts " .. vim.fs.basename(plugin_name),
                callback = spec.config
            })
        elseif spec.event then
            vim.api.nvim_create_autocmd(spec.event, {
                once = true,
                group = vim.api.nvim_create_augroup(vim.fs.basename(plugin_name) .. "-start", { clear = true }),
                desc = "Starts " .. vim.fs.basename(plugin_name),
                callback = spec.config
            })
        else
            spec.config()
        end
    end
end

function M.setup()
    local manpackpath = vim.fn.stdpath("data") .. "/manpack"

    if not vim.uv.fs_stat(manpackpath) then
        vim.uv.fs_mkdir(manpackpath, 511)
    end

    _G.Manpack = M
end

return M
