-- Pandoc Lua filter that converts links ending in .md to .html
-- This way, we can represent them on Github, and convert them to HTML
function Link(el)
  el.target = string.gsub(el.target, "%.md", ".html")
  return el
end
