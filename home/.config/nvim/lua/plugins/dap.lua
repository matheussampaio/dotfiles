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

vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<leader>dd", dap.step_over, { desc = "Debug: Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set breakpoint with condition" })
vim.keymap.set("n", "<leader>dp", function()
    dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug: Set breakpoint with log point message" })
vim.keymap.set("n", "<leader>dr", function()
    dap.repl.toggle({ height = 12 })
end, { desc = "Debug: Toggle Repl" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run last" })
vim.keymap.set("n", "<leader>dL", telescope.extensions.dap.list_breakpoints, { desc = "Debug: List breakpoints" })
vim.keymap.set("n", "<leader>de", function()
    dap.set_exception_breakpoints("default")
end, { desc = "Debug: Set exception breakpoint default" })
vim.keymap.set("n", "<leader>dE", function()
    dap.set_exception_breakpoints({})
end, { desc = "Debug: Set exception breakpoints" })
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
vim.keymap.set("n", "<leader>df", telescope.extensions.dap.frames, { desc = "Debug: Open frames" })
vim.keymap.set("n", "<leader>ds", telescope.extensions.dap.variables, { desc = "Debug: Open variables" })
vim.keymap.set({ "n", "v" }, "<leader>dK", dapWidgets.hover, { desc = "Debug: Hover" })
vim.keymap.set("n", "<leader>du", function()
    local widgets = dapWidgets
    widgets.sidebar(widgets.scopes).open()
    widgets.sidebar(widgets.frames).open()
end, { desc = "Debug: Open widgets" })
