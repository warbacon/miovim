local M = {}

M.manpackpath = vim.fs.joinpath(vim.fn.stdpath("data"), "manpack")

---@param plugin_name string
function M.plug(plugin_name)
    local plugin = "https://github.com/" .. plugin_name
    local plugin_dir = vim.fs.joinpath(M.manpackpath, vim.fs.basename(plugin_name))

    if not vim.uv.fs_stat(plugin_dir) then
        vim.fn.system({"git", "clone", "--depth=1", plugin, plugin_dir})
    end

    vim.opt.runtimepath:append(plugin_dir)

    local doc_dir = vim.fs.joinpath(plugin_dir, "doc")
    if vim.uv.fs_stat(doc_dir) then
        vim.schedule(function()
            vim.cmd("helptags " .. doc_dir)
        end)
    end
end


function M.setup()
    if not vim.uv.fs_stat(M.manpackpath) then
        vim.uv.fs_mkdir(M.manpackpath, 511)
    end
    _G.Manpack = M
end

return M
