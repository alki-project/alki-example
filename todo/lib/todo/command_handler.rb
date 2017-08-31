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
      @db.all.each do |(id,desc,status)|
        if status == "completed"
          desc = term.strikethrough desc
        end
        term.echo "#{id}. #{desc}"
      end
    end

    def add(desc)
      @db.add desc
    end

    def edit(id,desc)
      @db.update_desc(id,desc)
    end

    def complete(id)
      @db.complete id
    end
    
    def uncomplete(id)
      @db.uncomplete id
    end

    def remove(id)
      @db.remove id
    end

    def move(from,to)
      @db.move from, to
    end

    def help(term)
      term.echo <<-END.gsub(/^ */,'')
        All commands can be shortened to their first letters
        print
        add <description>
        edit <id> <description>
        complete <id>
        uncomplete <id>
        remove <id>
        move <from> <to>
        quit
      END
    end
  end
end
