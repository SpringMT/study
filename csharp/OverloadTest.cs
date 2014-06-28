using System;

namespace A
{
  class OverloadTest
  {
    public int A(int x) { Console.WriteLine("int" + x); return x; }
    public string A(string str) { Console.WriteLine("int" + str); return str; }
    public string A(int x, string str) { Console.WriteLine("int str" + x + str); return str; }
  }
}

class Test
{
  static void Main()
  {
    A.OverloadTest ot = new A.OverloadTest();
    ot.A(1);
    ot.A("str");
    ot.A(1, "str");
  }
}


