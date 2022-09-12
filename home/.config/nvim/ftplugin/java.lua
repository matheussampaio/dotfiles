-- configure makeprg if gradle is available
-- @TODO: search for gradlew in the project root folder
if vim.fn.filereadable("./gradlew") ~= 0 then
    vim.o.makeprg = "./gradlew build"
end

-- configure formatprg if google-java-format is in ~/.java/ folder
if vim.fn.filereadable("~/.java/google-java-format.jar") ~= 0 then
    vim.bo.formatprg = "java -jar ~/.java/google-java-format.jar -a -"
end

-- configure jdtls
local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local lsp = require("plugins/lsp")

local root_dir = jdtls_setup.find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}

if root_dir then
    local file = io.open(root_dir .. "/.bemol/ws_root_folders")

    if file then
        for line in file:lines() do
            table.insert(ws_folders_jdtls, "file://" .. line)
        end
        file:close()
    end
end

local jar_patterns = {
    "/.java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
    "/.java/vscode-java-decompiler/server/*.jar",
    "/.java/vscode-java-test/server/*.jar",
}
local bundles = {}

for _, jar_pattern in ipairs(jar_patterns) do
    for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
        if bundle ~= "" then
            table.insert(bundles, bundle)
        end
    end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities

extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
    on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })

        jdtls_setup.add_commands()

        lsp.on_attach(client, bufnr)

        vim.keymap.set("n", "<Leader>dt", jdtls.test_nearest_method, { buffer = true, desc = "Test nearest method" })
        vim.keymap.set("n", "<Leader>dc", jdtls.test_class, { buffer = true, desc = "Test class" })

        vim.keymap.set("n", "<Leader>lo", require('jdtls').organize_imports, { buffer = true, desc = "Organize imports" })

        vim.keymap.set("n", "<Leader>lc", require('jdtls').extract_constant, { buffer = true, desc = "Extract constant" })
        vim.keymap.set("x", "<Leader>lc", function() require('jdtls').extract_constant(true) end, { buffer = true, desc = "Extract to constant" })

        vim.keymap.set("n", "<Leader>lv", require('jdtls').extract_variable, { buffer = true, desc = "Extract variable" })
        vim.keymap.set("x", "<Leader>lv", function() require('jdtls').extract_variable(true) end, { buffer = true, desc = "Extract to variable" })

        vim.keymap.set("x", "<Leader>lm", function() require('jdtls').extract_method(true) end, { buffer = true, desc = "Extract to method" })
    end,
    capabilities = lsp.capabilities,
    cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. home .. "/.java/lombok.jar",
        '-Xms1g',
        '-Xmx4G',
        "-data", eclipse_workspace,
    },
    root_dir = root_dir,
    init_options = {
        bundles = bundles,
        workspaceFolders = ws_folders_jdtls,
        extendedClientCapabilities = extendedClientCapabilities,
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                referenceCodeLens = { enabled = true },
                implementationsCodeLens = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*"
                    }
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999
                    }
                }
            }
        }
    }
}

jdtls.start_or_attach(config)
