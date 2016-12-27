module Todo
  class StoreDb
    def initialize(store)
      @store = store
    end

    def all
      @store.read
    end

    def add(desc,status)
      @store.update do |entries|
        entries << [desc,status]
      end
      self
    end

    def remove(index)
      @store.update do |entries|
        check_index! entries, index
        entries.delete_at index
      end
      self
    end

    def update(index,desc,status)
      @store.update do |entries|
        check_index! entries, index
        cur = entries[index]
        entries[index] = [desc||cur[0],status||cur[1]]
      end
      self
    end

    def move(from_index,to_index)
      if from_index != to_index
        @store.update do |entries|
          check_index! entries, from_index
          check_index! entries, to_index
          entry = entries.delete_at from_index
          entries.insert to_index, entry
        end
      end
      self
    end
    
    private

    def check_index!(entries,index)
      if index < 0 || index >= entries.size
        raise ArgumentError.new("Invalid index")
      end
    end
  end
end
