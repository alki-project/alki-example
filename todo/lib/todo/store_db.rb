module Todo
  class StoreDb
    def initialize(store)
      @store = store
    end

    def all
      @store.read.map.with_index do |(msg,status),index|
        [index+1,msg,status]
      end
    end

    def add(desc)
      @store.update do |entries|
        entries << [desc,"active"]
      end
      self
    end

    def remove(id)
      index = to_index id
      @store.update do |entries|
        check_index! entries, index
        entries.delete_at index
      end
      self
    end

    def update_desc(id,new_desc)
      index = to_index id
      update index, new_desc, nil
    end

    def complete(id)
      index = to_index id
      update index, nil, "completed"
    end

    def uncomplete(id)
      index = to_index id
      update index, nil, "active"
    end

    def move(from_id,to_id)
      from_index = to_index from_id
      to_index = to_index to_id
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

    def to_index(index)
      index.to_i-1
    end

    def update(index,desc,status)
      @store.update do |entries|
        check_index! entries, index
        cur = entries[index]
        entries[index] = [desc||cur[0],status||cur[1]]
      end
      self
    end

    def check_index!(entries,index)
      if index < 0 || index >= entries.size
        raise ArgumentError.new("Invalid index")
      end
    end
  end
end
