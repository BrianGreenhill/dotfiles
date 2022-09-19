local find_test_line = function(bufnr, test)
	for i = 1, vim.api.nvim_buf_line_count(bufnr) do
		local line = vim.api.nvim_buf_get_lines(bufnr, i - 1, i, false)[1]
		if line:find(test) then
			return i - 1
		end
	end
end

local make_key = function(entry)
	assert(entry.Package, "Must have package:" .. vim.inspect(entry))
	assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
	return string.format("%s/%s", entry.Package, entry.Test)
end

local add_golang_test = function(state, entry)
	local key = make_key(entry)
	if state.tests[key] then
		return
	end
	state.tests[key] = {
		name = entry.Test,
		line = find_test_line(state.bufnr, entry.Test),
		output = {},
	}
end

local add_golang_output = function(state, entry)
	assert(state.tests, vim.inspect(state))
	table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
	state.tests[make_key(entry)].success = entry.Action == "pass"
end

local ns = vim.api.nvim_create_namespace("live-tests")
local group = vim.api.nvim_create_augroup("run-go", { clear = true })

local attach_to_buffer = function(bufnr, command)
	local state = {
		bufnr = bufnr,
		tests = {},
	}

	vim.api.nvim_buf_create_user_command(bufnr, "GoTestLineDiag", function()
		local winoptions = {
			relative = "editor",
			style = "minimal",
			width = 80,
			height = 20,
			row = 2,
			col = 2,
		}
		local line = vim.fn.line(".") - 1
		for _, test in pairs(state.tests) do
			if test.line == line then
				local buf = vim.api.nvim_create_buf(false, true)
				local win_id = vim.api.nvim_open_win(buf, true, winoptions)
				vim.inspect("window id: " .. win_id)
				vim.inspect("buf id: " .. buf)
				-- vim.cmd.new()
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, test.output)
			end
		end
	end, {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "*.go",
		callback = function()
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

			state = {
				bufnr = bufnr,
				tests = {},
			}

			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = function(_, data)
					if not data then
						return
					end

					for _, line in ipairs(data) do
						local decoded = vim.json.decode(line)
						if decoded.Action == "run" then
							add_golang_test(state, decoded)
						elseif decoded.Action == "output" then
							if not decoded.Test then
								return
							end

							add_golang_output(state, decoded)
						elseif decoded.Action == "pass" or decoded.Action == "fail" then
							mark_success(state, decoded)
						elseif decoded.Action == "pause" or decoded.Action == "cont" then
							-- Do nothing
						else
							error("Failed to handle " .. vim.inspect(data))
						end
					end
				end,

				on_exit = function()
					local test_results = {}
					for _, test in pairs(state.tests) do
						if test.line then
							table.insert(test_results, {
								bufnr = bufnr,
								lnum = test.line,
								col = 0,
								severity = test.success and vim.diagnostic.severity.INFO
									or vim.diagnostic.severity.ERROR,
								source = "go-test",
								message = test.success and "Test Passed" or "Test Failed",
								user_data = {},
							})
						end
					end

					vim.diagnostic.set(ns, bufnr, test_results, {})
				end,
			})
		end,
	})
end

vim.api.nvim_create_user_command("GoTestOnSave", function()
	local test_dir = vim.fn.input("Test Directory (default ./...): ")
	if test_dir == "" then
		test_dir = "./..."
	end
	attach_to_buffer(vim.api.nvim_get_current_buf(), { "go", "test", test_dir, "-v", "-json" })
end, {})
