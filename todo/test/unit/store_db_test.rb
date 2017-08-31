require 'alki/test'

require 'todo/store_db'

describe Todo::StoreDb do
  before do
    @store = Minitest::Mock.new
    @db = Todo::StoreDb.new @store
  end

  def expect_update(entries)
    @store.expect :update, true do |&blk|
      blk.call entries
      @saved = entries
    end
  end

  describe :all do
    it 'should return all entries from store' do
      @store.expect :read, [['test','active']]
      @db.all.must_equal [[1,'test','active']]
    end
  end

  describe :add do
    it 'should add entry to end of entries' do
      expect_update [['test','active']]
      @db.add 'test2'
      @saved.must_equal [['test','active'],['test2','active']]
    end
  end

  describe :remove do
    it 'should remove entry at index from entries' do
      expect_update [['test','active']]
      @db.remove 1
      @saved.must_equal []
    end

    it 'should raise ArgumentError if invalid index given' do
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.remove 0
      end
    end
  end

  describe :update_desc do
    it 'should update entry at index with new description' do
      expect_update [['test','active']]
      @db.update_desc 1, 'test2'
      @saved.must_equal [['test2','active']]
    end

    it 'should raise ArgumentError if invalid index given' do
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.update_desc(2, 'test2')
      end
    end
  end

  describe :complete do
    it 'should change status to completed' do
      expect_update [['test','active']]
      @db.complete 1
      @saved.must_equal [['test','completed']]
    end

    it 'should raise ArgumentError if invalid index given' do
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.complete(2)
      end
    end
  end

  describe :uncomplete do
    it 'should change status to active' do
      expect_update [['test','completed']]
      @db.uncomplete 1
      @saved.must_equal [['test','active']]
    end

    it 'should raise ArgumentError if invalid index given' do
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.uncomplete(2)
      end
    end
  end

  describe :move do
    it 'should move entry at index to new index' do
      expect_update [['1','a'],['2','a'],['3','a']]
      @db.move 1, 2
      @saved.must_equal [['2','a'],['1','a'],['3','a']]
    end

    it 'should raise ArgumentError if either index is invalid' do
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move(-1, 1)
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 4, 2
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 1, -1
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 1, 4
      end
    end
  end
end
