local Logger = require ( 'Logger' )
local   Path = require ( 'Path' )
local      P = require ( 'P' ) -- custom print function

-- Logger.LEVEL = Logger.INFO
Logger.LEVEL = Logger.DEBUG

P ( "----------------------" )
P ( " Path.GetChoices TEST." )
P ( "----------------------" )
local windows_dir_path = "C:\\share\\Documents\\"
local     wsl_dir_path = "/mnt/c/share/Documents/"

Path.Get_choices( wsl_dir_path )

P ( "----------------------" )
P ( " Path Convert TEST." )
P ( "----------------------" )

-- Path.Copy ( "./TEST1.txt", "./TEST2.txt" )
-- Path.Copy ( "/mnt/c/Users/August/.config/wezterm/wezterm.lua", "./wezterm.copy.lua" )
-- local str = "Hello World"
-- local new_str = str :gsub( "World", "Lua" )
-- P( new_str )  -- output: Hello Lua

-- local windows_path ="C:\\share\\Documents\\01-C-table04.png"
local windows_path = "C:\\share\\Documents\\01-C-table05.png"
local     wsl_path = "/mnt/c/share/Documents/01-C-table05.png"

P( "--- Convert     wsl -> windows path --- " )
local path2 = Path.Convert_windows_path ( wsl_path )
P( path2 )  -- output: Hello Lua
P( windows_path )  -- output: Hello Lua
P ( " " )
P( "--- Convert windows -> wsl     path --- " )
local path3 = Path.Convert_wsl_path ( windows_path )
P( path3 )
P( wsl_path )  -- output: Hello Lua
-- Convert windows -> wsl path
-- P( windows_path :gsub( 'C:\\', '/mnt' ) :gsub( '\\', '/' ) :gsub ( '//', '/' ) )
-- P( wsl_path  :gsub( '/', '\\\\' ) :gsub('\\\\mnt', 'C:' )  :gsub('\\c\\', '' ))
