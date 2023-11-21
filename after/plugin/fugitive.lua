function git_reset_hard()
    local commit_id = vim.fn.input("Enter commit ID: ")
    if commit_id == "" then
        print("No commit ID entered")
    else
        vim.cmd("G reset --hard " .. commit_id)
    end
end
function create_git_branch()
    local branch_name = vim.fn.input("Enter branch: ")
    if branch_name == "" then
        print("No branch name entered")
    else
        vim.cmd("G branch " .. branch_name)
        vim.cmd("G switch " .. branch_name)
    end
end
function delete_git_branch()
    local branch_name = vim.fn.input("Enter branch: ")
    if branch_name == "" then
        print("No branch name entered")
    else
        vim.cmd("G branch -d " .. branch_name)
    end
end
function merge_git_branch()
    local branch_name = vim.fn.input("Enter merged to branch: ")
    if branch_name == "" then
        print("No branch name entered")
    else
        vim.cmd("G merge " .. branch_name)
    end
end
function git_fetch_merge()
    vim.cmd("G fetch")
    vim.cmd("G merge")
end
function git_clone()
    local repo_url = vim.fn.input("Enter repo URL: ")
    if repo_url == "" then
        print("No repo URL entered")
    else
        local current_dir = vim.fn.expand('%:p:h')
        vim.cmd("cd " .. current_dir)
        vim.cmd("G clone " .. repo_url)
    end
end
function fix_merge_conflict()
    local choice = vim.fn.input("Pick (l/r): ")
    if choice == "l" then
        vim.cmd("diffget //2")
    elseif choice == "r" then
        vim.cmd("diffget //3")
    else
        print("No choice entered")
    end
end
function write_and_git_commit()
    vim.cmd("w")
    vim.cmd("G add .")
    vim.cmd("G commit")
end
function git_open_commit()
    local remote_url = vim.fn.systemlist('git config --get remote.origin.url')[1]
    local author = string.match(remote_url, ".*/(.-)/.-%.git")
    local repository_name = string.match(remote_url, ".*/(.-)%.git")
    vim.cmd("!python3 ~/.local/bin/git_blame.py " .. author .. " " .. repository_name)
end
function go_to_current_file_dir()
    local current_dir = vim.fn.expand('%:p:h')
    vim.cmd("cd " .. current_dir)
end
vim.keymap.set("n", "<leader>go", [[<cmd>lua git_open_commit()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gf", [[<cmd>lua fix_merge_conflict()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gi", [[<cmd>lua git_clone()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gu", [[<cmd>lua git_reset_hard()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gm", [[<cmd>lua merge_git_branch()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gbc", [[<cmd>lua create_git_branch()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gbd", [[<cmd>lua delete_git_branch()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gbs", "<cmd>Gvdiffsplit!<cr>", {silent = true})
vim.keymap.set("n", "<leader>gpl", [[<cmd>lua git_fetch_merge()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gc", [[<cmd>lua write_and_git_commit()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gr", [[<cmd>lua go_to_current_file_dir()<cr>]], {silent = true})
vim.keymap.set("n", "<leader>gl", "<cmd>G log --oneline --graph --decorate --all<cr>", {silent = true})
vim.keymap.set("n", "<leader>gt", "<cmd>G tag<cr>", {silent = true})
vim.keymap.set("n", "<leader>gbl", "<cmd>G blame<cr>", {silent = true})
vim.keymap.set("n", "<leader>gps", "<cmd>G push origin main<cr>", {silent = true})
vim.keymap.set("n", "<leader>gst", "<cmd>G<cr>", {silent = true})
vim.keymap.set("n", "<leader>gd", "<cmd>G diff<cr>", {silent = true})
vim.keymap.set("n", "<leader><leader>f", "<cmd>so ~/.config/nvim/after/plugin/fugitive.lua<cr>", {silent = true})
