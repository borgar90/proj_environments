require 'os'
require 'launchy'

projects = {
  "admin-panel-server" => {
    path: "/Users/borgarstensrud/Desktop/Git/com-future-tech-admin-panel-cms/server",
    compas_uri:"mongodb://localhost:27017/natours",
    tabs: [
      "http://localhost:3000",
      "https://google.com/search?q=project1",
      "https://github.com/user/project1"
    ]
  },
  "admin-panel-frontend" => {
    path: "/Users/borgarstensrud/Desktop/Git/com-future-tech-admin-panel-cms/admin-panel-by-future-tech",
    compas_uri:"mongodb://localhost:27017/natours",
    tabs: [
      "http://localhost:4000",
      "https://google.com/search?q=project2",
      "https://github.com/user/project2"
    ]
  }
}




def open_vs_code(project_path)
    # Check if the VS Code command-line tool is available
    if system("which code > /dev/null 2>&1")
      # Attempt to open VS Code and check if the operation was successful
      unless system("code #{project_path} --new-window")
        puts "Failed to open VS Code at #{project_path}. Please check the path and permissions."
      end
    else
      puts "VS Code command 'code' not found. Please ensure it's installed and in your PATH."
    end
  end
  
  
def open_mongodb_gui
  # Starter MongoDB GUI avhengig av operativsystemet
  if OS.mac?
    system("open -a 'MongoDB Compass'")
  elsif OS.windows?
    system("start MongoDBCompass")
  else
    puts "MongoDB GUI not supported on this OS"
  end
end

def open_terminal(project_path)
  # Åpner en terminal og navigerer til prosjektet
  if OS.mac?
    system("osascript -e 'tell application \"Terminal\" to do script \"cd #{project_path}\"'")
  elsif OS.windows?
    system("start cmd /k cd #{project_path}")
  else
    system("gnome-terminal --working-directory=#{project_path}")
  end
end

def open_chrome_with_tabs(project_tabs)
  # Åpner Chrome Beta med forhåndsdefinerte faner for prosjektet
  chrome_command = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --new-window"

  # Appends each tab URL to the command to open them all in the same window
  project_tabs.each do |tab|
    chrome_command += " #{tab}"
  end

  # Executes the command to open all tabs in a single window
  system(chrome_command)
end


projects.each do |name, config|
    puts "Opening environment for #{name}"
    open_vs_code(config[:path])
    open_mongodb_gui
    open_terminal(config[:path])
    open_chrome_with_tabs(config[:tabs])
  end
  