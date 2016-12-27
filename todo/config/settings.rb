Alki do
  set(:home) { ENV['HOME'] }

  set(:db_path) { ENV['TODO_DB_PATH'] || File.join(home,'.todo_db') }

  set :prompt, '> '
end
