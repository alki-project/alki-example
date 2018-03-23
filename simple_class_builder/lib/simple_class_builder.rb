require 'alki/support'

module SimpleClassBuilder
  def self.build(settings,&blk)
    # Alki::Support provides a handful of basic utility methods.
    # create_constant will create the named constant with the given value. 
    klass = Class.new(&blk)
    Alki::Support.create_constant settings[:constant_name], klass
  end
end
