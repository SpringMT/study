class Foo
  def foofoo
    @a= 1
  end
  def a
    @a
  end
  def b
    @b
  end
end

class Baa < Foo
  def baa_a
    @a
  end
end

obj = Foo.new
obj.foofoo

p obj.a
p Foo.new.b
p Baa.new.baa_a
