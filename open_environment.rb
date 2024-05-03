require 'os'
require 'launchy'
require 'json'


# Reads the project configuration from a JSON file
def read_projects(file_path)
    file = File.read(file_path)
    JSON.parse(file, symbolize_names: true)
  end
  
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
  
  
def open_mongodb_gui(project_uri)
  # Starter MongoDB GUI avhengig av operativsystemet
  if OS.mac?
    system("open -a 'MongoDB Compass' --args #{project_uri}")
  elsif OS.windows?
    system("start MongoDBCompass #{project_uri}")

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


# Main execution starts here
begin
    projects = JSON.parse(ARGV[0], symbolize_names: true)
    puts projects.inspect  # Add this line to see the structure of 'projects'
    projects.each do |name, config|
      puts "Opening environment for #{name}"
      open_vs_code(config[:vscodePath])
      open_mongodb_gui(config[:mongodbUri])
      open_terminal(config[:terminalPath])
      open_chrome_with_tabs(config[:chromeTabs])
    end
  rescue JSON::ParserError => e
    puts "Error parsing JSON: #{e}"
  end
  
  