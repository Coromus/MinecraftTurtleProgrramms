---------------- using ------------------
--local QuestionScript = require("Classes.Question")
--local Question = QuestionScript.new()

---------------- class ------------------
local Question = {}
Question.__index = Question

function Question.new()
    local self = setmetatable({}, Question)
    return self
end

function Question:ask(question, answers)
    print(question)
    local result = nil
    while result == nil do
        local _, chr = os.pullEvent("char")
        for i, v in pairs(answers) do
            if v == string.upper(chr) then
                result = v
                break
            end
        end
    end
    return result
end

return Question