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
      entries = [['test','active']]
      @store.expect :read, entries
      @db.all.must_equal entries
    end
  end

  describe :add do
    it 'should add entry to end of entries' do
      expect_update [['test','active']]
      @db.add 'test2', 'active'
      @saved.must_equal [['test','active'],['test2','active']]
    end
  end

  describe :remove do
    it 'should remove entry at index from entries' do
      expect_update [['test','active']]
      @db.remove 0
      @saved.must_equal []
    end
  end

  describe :update do
    it 'should update entry at index with new data' do
      expect_update [['test','active']]
      @db.update 0, 'test2', 'completed'
      @saved.must_equal [['test2','completed']]
    end

    it 'should not change description if nil given' do
      expect_update [['test','active']]
      @db.update 0, nil, 'completed'
      @saved.must_equal [['test','completed']]
    end

    it 'should not change status if nil given' do
      expect_update [['test','active']]
      @db.update 0, 'test2', nil
      @saved.must_equal [['test2','active']]
    end

    it 'should raise ArgumentError if invalid index given' do
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.update(-1, nil, nil)
      end
      expect_update [['test','active']]
      assert_raises ArgumentError do
        @db.update(1, nil, nil)
      end
    end
  end

  describe :move do
    it 'should move entry at index to new index' do
      expect_update [['1','a'],['2','a'],['3','a']]
      @db.move 0, 1
      @saved.must_equal [['2','a'],['1','a'],['3','a']]
    end

    it 'should raise ArgumentError if either index is invalid' do
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move(-1, 1)
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 3, 1
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 0, -1
      end
      expect_update [['1','a'],['2','a'],['3','a']]
      assert_raises ArgumentError do
        @db.move 0, 3
      end
    end
  end
end
