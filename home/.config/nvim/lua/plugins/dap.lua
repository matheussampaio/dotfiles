local dap = require("dap")

dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005
    }
}

local telescope = require("telescope")
local dapWidgets = require("dap.ui.widgets")

vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dd", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<leader>dr", function()
    dap.repl.toggle({ height = 12 })
end)
vim.keymap.set("n", "<leader>dl", dap.run_last)
vim.keymap.set("n", "<leader>dL", telescope.extensions.dap.list_breakpoints)
vim.keymap.set("n", "<leader>de", function()
    dap.set_exception_breakpoints("default")
end)
vim.keymap.set("n", "<leader>dE", function()
    dap.set_exception_breakpoints({})
end)
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
vim.keymap.set("n", "<leader>df", telescope.extensions.dap.frames)
vim.keymap.set("n", "<leader>ds", telescope.extensions.dap.variables)
vim.keymap.set({ "n", "v" }, "<leader>K", dapWidgets.hover)
vim.keymap.set("n", "<leader>du", function()
    local widgets = dapWidgets
    widgets.sidebar(widgets.scopes).open()
    widgets.sidebar(widgets.frames).open()
end)
