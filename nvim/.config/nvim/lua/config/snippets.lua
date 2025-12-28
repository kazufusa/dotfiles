-- Custom snippets configuration
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Helper function to get current datetime
local function get_datetime()
  return os.date("%Y-%m-%dT%H:%M:%S")
end

local function get_date()
  return os.date("%Y-%m-%d")
end

local function get_time()
  return os.date("%H:%M:%S")
end

-- Add snippets for all file types
ls.add_snippets("all", {
  -- datetime: 2025-12-28T11:00:00
  s("datetime", {
    f(get_datetime, {}),
  }),

  -- date: 2025-12-28
  s("date", {
    f(get_date, {}),
  }),

  -- time: 11:00:00
  s("time", {
    f(get_time, {}),
  }),
})
