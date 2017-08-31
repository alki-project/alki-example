Alki do
  try_mount :reloader, 'alki/reload', enable: true

  load :settings

  func :run do
    interface.run
  end

  tag :main_loop
  service :interface do
    require 'todo/readline_interface'
    Todo::ReadlineInterface.new settings.prompt, handler
  end

  service :handler do
    require 'todo/command_handler'
    Todo::CommandHandler.new db
  end

  service :db do
    require 'todo/store_db'
    Todo::StoreDb.new file_store
  end

  service :file_store do
    require 'todo/json_file_store'
    Todo::JsonFileStore.new settings.db_path
  end
end
