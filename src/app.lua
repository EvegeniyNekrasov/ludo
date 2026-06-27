local M = {}

local function parse_csv(line)
    local result = {}
    local from = 1
    local separator = ","
    
    while true do
        local start_pos, end_pos = string.find(
            line,
            separator,
            from,
            true
        )

        if not start_pos then
            table.insert(result, string.sub(line, from))
            break
        end

        local field = string.sub(line, from, start_pos - 1)
        table.insert(result, field)
        from = end_pos + 1
    end

    return result
end
function M.run()
    print("Init app")

    local file, err = io.open("src/ddbb.csv", "r")

    if not file then
        print("Could not open file: " .. tostring(err))
        return
    end

    for line in file:lines() do
        local values = parse_csv(line)
        for i, v in ipairs(values) do
            print(i, v)
        end
    end

    file:close()
end


return M
