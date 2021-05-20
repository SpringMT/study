class A
end

module B
  def self.b(test, &block)
    p 'module B'
    p test
    p yield
    p 'bbbbb'
  end
end

A.extend B

module C
  def self.prepended(base)
    class << base
      prepend ClassMethods
    end
  end

  module ClassMethods
    def b(test, &block)
      p 'module C start'
      p shard_id
      super(test, &block)
    end
  end
end

A.prepend C

A.b(:test, group: 'group', shard_id: 1) do
  p 'block call'
end


