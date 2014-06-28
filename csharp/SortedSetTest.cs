using System;
using System.Linq;
using System.Collections.Generic;

class TestSort
{
  public string Name { get; set; }
  public int Age { get; set; }
}

class HelloWorld
{
  static void Main(string[] args)
  {
    Console.WriteLine(11111);
    //SortedSet<TestSort> s = new SortedSet<TestSort>(new TestSort[] {new TestSort {Name="bar", Age=1}});
    HashSet<TestSort> s = new HashSet<TestSort>();
    s.Add(  new TestSort {Name="foo6", Age=6} );
    s.Add(  new TestSort {Name="bar1", Age=1} );
    s.Add(  new TestSort {Name="hoge5", Age=5} );
    //SortedSet<TestSort> s = new SortedSet<TestSort>(new TestSort[] {
    //  new TestSort {Name="foo", Age=6},
    //  new TestSort {Name="bar", Age=1},
    //  new TestSort {Name="hoge", Age=5},
    //});
    Console.WriteLine(22222);
    Console.WriteLine(s);
    IEnumerable<TestSort>new_s = s.OrderByDescending(pet => pet.Age);
    foreach (TestSort ts in new_s)
    {
      Console.WriteLine(ts.Name);
    }
  }
}
