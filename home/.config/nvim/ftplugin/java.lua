local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local lsp = require("plugins/lsp")
local dap = require("dap")

local root_dir = jdtls_setup.find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")

-- -- configure formatprg if google-java-format is in ~/.java/ folder
-- if vim.fn.filereadable(home .. "/.java/google-java-format.jar") > 0 then
--     vim.bo.formatprg = "java -jar " .. home .. "/.java/google-java-format.jar -a -"
-- end

-- vim.bo.makeprg = "brazil-build format && brazil-build"
--
-- -- Examples:
-- -- [checkstyle] [ERROR] /path/to/file/Main.java:15:29: Variable 'annotation' should be declared final. [FinalLocalVariable]
-- -- [checkstyle] [ERROR] /path/to/file/Main.java:15: Variable 'annotation' should be declared final. [FinalLocalVariable]
-- vim.bo.errorformat = "[%.%#checkstyle] [%t%.%#] %f:%l:%c: %m,[%.%#checkstyle] [%t%.%#] %f:%l: %r"

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
    group = vim.api.nvim_create_augroup('java__codelenses', { clear = true }),
    pattern = { '*.java' },
    callback = function()
        local found = false

        for _, value in pairs(vim.lsp.get_active_clients()) do
            if value.name == 'jdtls' then
                found = true
                break
            end
        end

        if not found then
            return false
        end

        vim.lsp.codelens.refresh()

        return true
    end,
})

local function get_workspace_folders()
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

    return ws_folders_jdtls
end

local function get_jar_bundles()
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

    return bundles
end

-- I install openjdk with `brew`. This functions checks which versions is currently installed and adds all of them as runtimes to JDTLS.
local function get_java_runtimes()
    local runtimes = {}
    for _, folder in ipairs(vim.split(vim.fn.glob(os.getenv("HOMEBREW_PREFIX") .. "/opt/openjdk@*"), "\n")) do
        if folder ~= "" then
            local version = folder:match(".*openjdk@(%d+)")

            if version == '8' then
                version = '1.8'
            end

            if version ~= '21' then
                table.insert(runtimes, {
                    version = tonumber(version),
                    name = 'JavaSE-' .. version,
                    path = folder .. '/libexec',
                })
            end
        end
    end

    local function sort_by_version(a, b)
        return a.version > b.version
    end

    table.sort(runtimes, sort_by_version)

    if #runtimes > 0 then
        runtimes[1].default = true
    end

    return runtimes
end

local function on_attach(client, bufnr)
    jdtls.setup_dap({ hotcodereplace = "auto" })

    lsp.on_attach(client, bufnr)

    vim.keymap.set("n", "<Leader>lt", require('jdtls.tests').goto_subjects, { buffer = true, desc = "Toggle between test file and source" })

    vim.keymap.set("n", "<Leader>dt", jdtls.test_nearest_method, { buffer = true, desc = "Test nearest method" })
    vim.keymap.set("n", "<Leader>dT", jdtls.test_class, { buffer = true, desc = "Test class" })

    vim.keymap.set("n", "<Leader>lo", jdtls.organize_imports, { buffer = true, desc = "Organize imports" })

    vim.keymap.set("n", "<Leader>lc", jdtls.extract_constant, { buffer = true, desc = "Extract constant" })
    vim.keymap.set("x", "<Leader>lc", function() jdtls.extract_constant(true) end,
        { buffer = true, desc = "Extract to constant" })

    vim.keymap.set("n", "<Leader>lv", jdtls.extract_variable_all, { buffer = true, desc = "Extract variable" })
    vim.keymap.set("x", "<Leader>lv", function() jdtls.extract_variable_all(true) end,
        { buffer = true, desc = "Extract to variable" })

    vim.keymap.set("x", "<Leader>lm", function() jdtls.extract_method(true) end,
        { buffer = true, desc = "Extract to method" })

    vim.lsp.codelens.refresh()
end

local config = {
    capabilities = lsp.capabilities,
    on_attach = on_attach,
    cmd = {
        "java",
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        "-javaagent:" .. home .. "/.java/lombok.jar",
        "-jar", vim.fn.glob(home .. "/.java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration", home .. "/.java/jdtls/config_linux",
        "-data", home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
    },
    root_dir = root_dir,
    init_options = {
        bundles = get_jar_bundles(),
        workspaceFolders = get_workspace_folders(),
        extendedClientCapabilities = vim.tbl_deep_extend(
            'force',
            jdtls.extendedClientCapabilities,
            {
                resolveAdditionalTextEditsSupport = true,
                onCompletionItemSelectedCommand = "editor.action.triggerParameterHints",
            }
        ),
    },
    settings = {
        java = {
            settings = {
                url = home .. '/.java/settings.txt'
            },
            format = {
                settings = {
                    url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
                    profile = 'GoogleStyle'
                }
            },
            cleanup = {
                actionsOnSave = {
            --         -- adds the deprecated annotation to classes/fields/methods that are marked deprecated in the javadoc.
            --         'addDeprecated',
                    -- adds the 'final' modifier where possible.
                    'addFinalModifier',
            --         -- adds the override annotation to all methods that override any parent method.
            --         'addOverride',
            --         -- inverts calls to Object.equals(Object) and String.equalsIgnoreCase(String) to avoid useless null pointer exception.
            --         'invertEquals',
            --         -- several actions to clean up lambda expression.
            --         'lambdaExpression',
            --         -- prefixes all (non-static) field and method accesses with this.
            --         -- 'qualifyMembers',
            --         -- prefixes all static member accesses with the classes name.
            --         -- 'qualifyStaticMembers',
            --         -- converts string concatenaton to Text Blocks.
            --         'stringConcatToTextBlock',
            --         -- converts a switch statement to a switch expression.
            --         'switchExpression',
            --         -- simplifies the finally block to using a try-with-resource statement.
            --         'tryWithResource',
                }
            },
            configuration = {
                runtimes = get_java_runtimes()
            },
            completion = {
                enabled = true,
                favoriteStaticMembers = {
                    "org.assertj.core.api.Assertions.*",
                    "org.hamcrest.MatcherAssert.*",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.mockito.ArgumentMatchers.*",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                },
                importOrder = {},
            },
            contentProvider = { preferred = "fernflower" },
            implementationsCodeLens = { enabled = true },
            inlayhints = {
                parameterNames = {
                    enabled = true
                }
            },
            jdt = {
                ls = {
                    lombokSupport = {
                        enabled = true
                    }
                }
            },
            referenceCodeLens = { enabled = true },
            references = {
                includeAccessors = true,
                includeDecompiledSources = true
            },
            rename = {
                enabled = true
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            signatureHelp = {
                enabled = true,
                description = {
                    enabled = true
                }
            },
        }
    },
    handlers = {
        -- Disables JDTLS loading progress messages in the cmdline
        ['language/status'] = function() end
    }
}

jdtls.start_or_attach(config)

dap.configurations.java = {
    {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005
    }
}
