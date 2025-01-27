local M = {}

M.icons = require("util.icons")
M.is_win = vim.uv.os_uname().sysname:find("Windows") ~= nil

--- Gets a path to a package in the Mason registry.
---@param pkg string
---@param path? string
function M.get_pkg_path(pkg, path)
    pcall(require, "mason")
    local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
    path = path or ""
    return root .. "/packages/" .. pkg .. "/" .. path
end

return M
