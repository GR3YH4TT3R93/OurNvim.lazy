local M = {}

function M.get_os()
  --- @diagnostic disable-next-line: undefined-field
  local os_name = vim.loop.os_uname().sysname

  if os_name == "Windows_NT" then
    return "Windows"
  elseif os_name == "Darwin" then
    return "macOS"
  elseif os_name == "Linux" then
    -- Check if the system is running Android
    if vim.env.ANDROID_ROOT then
      return "Android"
    end

    -- Determine the Linux distribution
    local distro = "Linux"
    local release_file = "/etc/os-release"

    local fd = io.open(release_file, "r")
    if fd then
      for line in fd:lines() do
        if line:match("^ID=") then
          distro = line:gsub("ID=", ""):gsub('"', "")
          break
        end
      end
      fd:close()
    end
    return "Linux (" .. distro .. ")"
  else
    -- Falback tests
    if M.is_mac() then
      return "macOS"
    elseif M.is_linux() then
      return "Linux"
    elseif M.is_windows() then
      return "Windows"
    else
      -- Failed to determine OS
      return "Unknown OS"
    end
  end
end

function M.move_with_count(count, direction, func)
  func(count * direction)
end

return M
