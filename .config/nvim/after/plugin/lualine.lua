local function get_root_dir()
    local current_dir = vim.fn.getcwd()
    return current_dir
end

local function file_lines()
    local last_line = vim.fn.line("$")
    local current_line = vim.fn.line(".")
    local last_col = vim.fn.col("$")
    local current_col = vim.fn.col(".")
    return current_col ..
        '/' .. last_col .. ':' ..
        current_line .. '/' .. last_line .. ' (' .. math.floor((current_line / last_line) * 100) .. '%%)'
end

local debounce_todo_num = 255
local debounce_result_todo_num = ''
local function todo_num()
    if debounce_todo_num == 255 then
        if string.find(get_root_dir(), "repos") or string.find(get_root_dir(), ".config") then
            local todo_count = io.popen('rg TODO: | wc -l'):read("*n")
            if todo_count == 1 then
                debounce_result_todo_num = todo_count .. ' todo'
            else
                debounce_result_todo_num = todo_count .. ' todos'
            end
        else
            debounce_result_todo_num = "- todos"
        end
        debounce_todo_num = 0
        return debounce_result_todo_num
    else
        debounce_todo_num = debounce_todo_num + 1
        return debounce_result_todo_num
    end
end

local debounce_codeline_num = 255
local debounce_result_codeline_num = ''
local function codeline_num()
    if debounce_codeline_num == 255 then
        if string.find(get_root_dir(), "repos") or string.find(get_root_dir(), ".config") then
            -- Remember to add new filetypes or directorys to BOTH `rg` calls
            -- To add new filetypes, just add a line containing `"-g '*.xy' " ..`
            local rg_include_files = "" ..
                "-g '*.rs' " ..
                "-g '*.c' " ..
                "-g '*.h' " ..
                "-g '*.cpp' " ..
                "-g '*.cs' " ..
                "-g '*.ino' " ..
                "-g '*.sh' " ..
                "-g '*.py' " ..
                "-g '*.svelte' " ..
                "-g '*.lua' " ..
                "-g '*.vue' " ..
                "-g '*.md' " ..
                "-g '*.js' " ..
                "-g '*.ts' " ..
                "-g '*.go' "
            -- To exclude a dir, just add a line containing `"-g '!*/xyz/*' " ..`
            local rg_exclude_dirs = "" ..
                "-g '!*/gdtf_parser/*' " ..
                "-g '!gdtf_parser/*' " ..
                "-g '!shows/*' "
            local empty_line_count = io.popen(
                    "rg --files " ..
                    rg_include_files ..
                    rg_exclude_dirs ..
                    "| xargs cat 2>/dev/null " ..
                    "| grep -c '^$'")
                :read("*n")
            local line_count = io.popen(
                    "rg --files " ..
                    rg_include_files ..
                    rg_exclude_dirs ..
                    "| xargs wc -l 2>/dev/null " ..
                    "| tail -n1 " ..
                    "| awk 'END {print $1}'")
                :read(
                    "*n")
            debounce_result_codeline_num = line_count ..
                " lines (" .. string.format("%.0f", (empty_line_count / line_count) * 100) .. "%% blank)"
            debounce_codeline_num = 0
            return debounce_result_codeline_num
        else
            return "- lines"
        end
    else
        debounce_codeline_num = debounce_codeline_num + 1
        return debounce_result_codeline_num
    end
end


require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'diagnostics', 'searchcount', 'selectioncount' },
        lualine_x = {},
        lualine_y = { file_lines, todo_num, codeline_num },
        lualine_z = { get_root_dir }
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
