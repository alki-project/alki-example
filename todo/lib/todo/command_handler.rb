module Todo
  class CommandHandler
    def initialize(db)
      @db = db
    end

    def handle(term, line)
      case line
      when /^p(?:rint)?/ then print term
      when /^a(?:dd)? +(.*)/ then add $1
      when /^e(?:dit)? +(\d+) +(.*)/ then edit $1, $2
      when /^c(?:omplete)? +(\d+)/ then complete $1
      when /^u(?:ncomplete)? +(\d+)/ then uncomplete $1
      when /^r(?:emove)? +(\d+)/ then remove $1
      when /^m(?:ove)? +(\d+) +(\d+)/ then move $1, $2
      when /^q(?:uit)?/ then return false
      else help term
      end
      true
    rescue ArgumentError => e
      term.echo e.message
      true
    end

    private

    def print(term)
      @db.all.each.with_index do |(msg,status),i|
        if status == "completed"
          # Strikethrough msg
          msg = "\e[9m#{msg}\e[0m"
        end
        term.echo "#{i+1}. #{msg}"
      end
    end

    def add(msg)
      @db.add(msg,"active")
    end

    def edit(id,msg)
      @db.update(id.to_i-1,msg,nil)
    end

    def complete(id)
      @db.update(id.to_i-1,nil,"completed")
    end
    
    def uncomplete(id)
      @db.update(id.to_i-1,nil,"active")
    end

    def remove(id)
      @db.remove(id.to_i-1)
    end

    def move(from,to)
      @db.move(from.to_i-1,to.to_i-1)
    end

    def help(term)
      term.echo <<-END.gsub(/^ */,'')
        All commands can be shortened to their first letters
        print
        add <msg>
        edit <id> <msg>
        complete <id>
        uncomplete <id>
        remove <id>
        move <from> <to>
        quit
      END
    end
  end
end
