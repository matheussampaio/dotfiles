local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")
local lsp = require("plugins/lsp")
local dap = require("dap")

local root_dir = jdtls_setup.find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- configure formatprg if google-java-format is in ~/.java/ folder
if vim.fn.filereadable(home .. "/.java/google-java-format.jar") > 0 then
    vim.bo.formatprg = "java -jar " .. home .. "/.java/google-java-format.jar -a -"
end

-- vim.bo.makeprg = "brazil-build format && brazil-build"
--
-- -- Examples:
-- -- [checkstyle] [ERROR] /path/to/file/Main.java:15:29: Variable 'annotation' should be declared final. [FinalLocalVariable]
-- -- [checkstyle] [ERROR] /path/to/file/Main.java:15: Variable 'annotation' should be declared final. [FinalLocalVariable]
-- vim.bo.errorformat = "[%.%#checkstyle] [%t%.%#] %f:%l:%c: %m,[%.%#checkstyle] [%t%.%#] %f:%l: %r"
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

local config = {
    capabilities = lsp.capabilities,
    on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })

        jdtls_setup.add_commands()

        lsp.on_attach(client, bufnr)

        vim.keymap.set("n", "<Leader>dt", jdtls.test_nearest_method, { buffer = true, desc = "Test nearest method" })
        vim.keymap.set("n", "<Leader>dT", jdtls.test_class, { buffer = true, desc = "Test class" })

        vim.keymap.set("n", "<Leader>lo", jdtls.organize_imports, { buffer = true, desc = "Organize imports" })

        vim.keymap.set("n", "<Leader>lc", jdtls.extract_constant, { buffer = true, desc = "Extract constant" })
        vim.keymap.set("x", "<Leader>lc", function() jdtls.extract_constant(true) end,
            { buffer = true, desc = "Extract to constant" })

        vim.keymap.set("n", "<Leader>lv", jdtls.extract_variable, { buffer = true, desc = "Extract variable" })
        vim.keymap.set("x", "<Leader>lv", function() jdtls.extract_variable(true) end,
            { buffer = true, desc = "Extract to variable" })

        vim.keymap.set("x", "<Leader>lm", function() jdtls.extract_method(true) end,
            { buffer = true, desc = "Extract to method" })
    end,
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
        "-data", eclipse_workspace,
    },
    root_dir = root_dir,
    init_options = {
        bundles = bundles,
        workspaceFolders = ws_folders_jdtls,
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
            cleanup = {
                actionsOnSave = {
                    -- adds the deprecated annotation to classes/fields/methods that are marked deprecated in the javadoc.
                    'addDeprecated',
                    -- adds the 'final' modifier where possible.
                    'addFinalModifier',
                    -- adds the override annotation to all methods that override any parent method.
                    'addOverride',
                    -- inverts calls to Object.equals(Object) and String.equalsIgnoreCase(String) to avoid useless null pointer exception.
                    'invertEquals',
                    -- several actions to clean up lambda expression.
                    'lambdaExpression',
                    -- prefixes all (non-static) field and method accesses with this.
                    'qualifyMembers',
                    -- prefixes all static member accesses with the classes name.
                    'qualifyStaticMembers',
                    -- converts string concatenaton to Text Blocks.
                    'stringConcatToTextBlock',
                    -- converts a switch statement to a switch expression.
                    'switchExpression',
                    -- simplifies the finally block to using a try-with-resource statement.
                    'tryWithResource',
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-17',
                        path = vim.fn.expandcmd("$JAVA_HOME_17")
                    },
                    {
                        name = 'JavaSE-11',
                        path = vim.fn.expandcmd("$JAVA_HOME_11"),
                        default = true,
                    },
                    {
                        name = 'JavaSE-1.8',
                        path = vim.fn.expandcmd("$JAVA_HOME_8"),
                    }
                },
            },
            completion = {
                favoriteStaticMembers = {
                    "io.crate.testing.Asserts.assertThat",
                    "org.assertj.core.api.Assertions.assertThat",
                    "org.assertj.core.api.Assertions.assertThatThrownBy",
                    "org.assertj.core.api.Assertions.assertThatExceptionOfType",
                    "org.assertj.core.api.Assertions.catchThrowable",
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                importOrder = {
                    'java',
                    'javax',
                    'org',
                    'com',
                },
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
            saveActions = {
                organizeImports = true
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
