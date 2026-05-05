local M = {}

local function dedupe(list)
    local seen = {}
    local result = {}

    for _, item in ipairs(list) do
        if item and item ~= "" and not seen[item] then
            seen[item] = true
            table.insert(result, item)
        end
    end

    return result
end

function M.get_default_remote_branch()
    local result = vim.fn.systemlist({
        "git",
        "symbolic-ref",
        "--short",
        "refs/remotes/origin/HEAD",
    })

    if vim.v.shell_error == 0 and result[1] and result[1] ~= "" then
        return result[1] -- usually origin/main or origin/master
    end

    return "origin/main"
end

function M.git_refs()
    local result = vim.fn.systemlist({
        "git",
        "for-each-ref",
        "--format=%(refname:short)",
        "refs/heads",
        "refs/remotes",
    })

    if vim.v.shell_error ~= 0 then
        return {}
    end

    local refs = {}

    for _, ref in ipairs(result) do
        if ref ~= "origin/HEAD" then
            table.insert(refs, ref)
        end
    end

    table.sort(refs)
    return refs
end

function M.complete_git_refs(arg_lead)
    local refs = M.git_refs()

    if not arg_lead or arg_lead == "" then
        return refs
    end

    return vim.tbl_filter(function(ref)
        return ref:find(vim.pesc(arg_lead)) == 1
    end, refs)
end

function M.review_mr(target, source)
    target = target or M.get_default_remote_branch()
    source = source or "HEAD"

    vim.cmd("DiffviewOpen " .. target .. "..." .. source .. " --imply-local")
end

function M.review_mr_commits(target, source)
    target = target or M.get_default_remote_branch()
    source = source or "HEAD"

    vim.cmd(
        "DiffviewFileHistory --range="
            .. target
            .. "..."
            .. source
            .. " --right-only --no-merges"
    )
end

function M.open_working_tree()
    vim.cmd("DiffviewOpen")
end

function M.open_all_local_changes()
    vim.cmd("DiffviewOpen HEAD")
end

function M.open_staged_changes()
    vim.cmd("DiffviewOpen --cached")
end

function M.open_current_file_history()
    vim.cmd("DiffviewFileHistory %")
end

function M.open_repo_history()
    vim.cmd("DiffviewFileHistory")
end

function M.open_stash_history()
    vim.cmd("DiffviewFileHistory -g --range=stash")
end

function M.toggle_diffview()
    local ok, lib = pcall(require, "diffview.lib")

    if ok and next(lib.views) ~= nil then
        vim.cmd("DiffviewClose")
    else
        vim.cmd("DiffviewOpen")
    end
end

function M.select_ref(prompt, default, callback)
    local refs = M.git_refs()
    refs = dedupe({ default, "HEAD", unpack(refs) })

    vim.ui.select(refs, {
        prompt = prompt,
    }, function(choice)
        if choice then
            callback(choice)
        end
    end)
end

function M.review_mr_select_target()
    M.select_ref("MR target branch:", M.get_default_remote_branch(), function(target)
        M.review_mr(target, "HEAD")
    end)
end

function M.review_mr_select_target_and_source()
    M.select_ref("MR target branch:", M.get_default_remote_branch(), function(target)
        M.select_ref("MR source branch/ref:", "HEAD", function(source)
            M.review_mr(target, source)
        end)
    end)
end

function M.review_mr_commits_select()
    M.select_ref("MR target branch:", M.get_default_remote_branch(), function(target)
        M.select_ref("MR source branch/ref:", "HEAD", function(source)
            M.review_mr_commits(target, source)
        end)
    end)
end

function M.setup_commands()
    vim.api.nvim_create_user_command("ReviewMR", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })

        local target = args[1] or M.get_default_remote_branch()
        local source = args[2] or "HEAD"

        M.review_mr(target, source)
    end, {
        nargs = "*",
        complete = M.complete_git_refs,
    })

    vim.api.nvim_create_user_command("ReviewMRCommits", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })

        local target = args[1] or M.get_default_remote_branch()
        local source = args[2] or "HEAD"

        M.review_mr_commits(target, source)
    end, {
        nargs = "*",
        complete = M.complete_git_refs,
    })

    vim.api.nvim_create_user_command("ReviewMRSelect", function()
        M.review_mr_select_target_and_source()
    end, {})
end

return M
