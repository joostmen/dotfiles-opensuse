-- lua/utils/telescope_tabs.lua

-- Create a Lua module table.
-- Other files can call functions from this table after requiring it.
local M = {}

-- Main function that opens a Telescope picker listing all Neovim tabs.
function M.find_tabs()
   -- Telescope building blocks.
   -- These are part of Telescope itself, not separate plugins.
   local pickers = require("telescope.pickers")
   local finders = require("telescope.finders")
   local conf = require("telescope.config").values
   local actions = require("telescope.actions")
   local action_state = require("telescope.actions.state")

   -- This table will hold the tab entries shown in Telescope.
   local tabs = {}

   -- Get all open Neovim tabs.
   for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
      -- Convert the tab handle into a visible tab number: 1, 2, 3, etc.
      local tabnr = vim.api.nvim_tabpage_get_number(tabpage)

      -- Get all windows inside this tab.
      -- A tab can contain multiple split windows.
      local wins = vim.api.nvim_tabpage_list_wins(tabpage)

      -- This will hold the visible buffer/file names for this tab.
      local names = {}

      -- Loop over every window in this tab.
      for _, win in ipairs(wins) do
         -- Get the buffer shown in this window.
         local bufnr = vim.api.nvim_win_get_buf(win)

         -- Get the full file path for that buffer.
         local name = vim.api.nvim_buf_get_name(bufnr)

         -- Some buffers have no file name, for example a new unsaved buffer.
         if name == "" then
            name = "[No Name]"
         else
            -- Convert a full path like:
            -- C:\project\app.py
            -- into only:
            -- app.py
            name = vim.fn.fnamemodify(name, ":t")
         end

         -- Add this file/buffer name to the tab label.
         table.insert(names, name)
      end

      -- Add one entry for this tab.
      -- Example label:
      -- Tab 1: app.py | terminal | README.md
      table.insert(tabs, {
         tabnr = tabnr,
         label = "Tab " .. tabnr .. ": " .. table.concat(names, " | "),
      })
   end

   -- Create and open the Telescope picker.
   pickers
       .new({}, {
          -- Title shown at the top of the Telescope popup.
          prompt_title = "Tabs",

          -- Tell Telescope what data to show.
          finder = finders.new_table({
             results = tabs,

             -- Convert each tab entry into something Telescope understands.
             entry_maker = function(entry)
                return {
                   -- The original data. We use this later to jump to the tab.
                   value = entry,

                   -- What the user sees in the picker.
                   display = entry.label,

                   -- What Telescope searches against when you type.
                   ordinal = entry.label,
                }
             end,
          }),

          -- Use Telescope's normal fuzzy sorter.
          sorter = conf.generic_sorter({}),

          -- Define what happens when you select a tab and press Enter.
          attach_mappings = function(prompt_bufnr)
             actions.select_default:replace(function()
                -- Get the selected Telescope entry.
                local selection = action_state.get_selected_entry()

                -- Close the Telescope popup.
                actions.close(prompt_bufnr)

                -- Jump to the selected tab.
                -- Example command:
                -- 2tabnext
                vim.cmd(selection.value.tabnr .. "tabnext")
             end)

             -- Returning true keeps the mappings active.
             return true
          end,
       })
       :find()
end

-- Return the module so other files can require it.
return M
