-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.git.blame-nvim" },
  { import = "astrocommunity.git.diffview-nvim" },
  -- { import = "astrocommunity.pack.bash" },
  -- { import = "astrocommunity.pack.cpp" },
  -- { import = "astrocommunity.pack.go" },
  -- { import = "astrocommunity.pack.java" },
  -- { import = "astrocommunity.pack.sql" },
  -- { import = "astrocommunity.pack.rust" },
  -- { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.motion.leap-nvim" },
}
