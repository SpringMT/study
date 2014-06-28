using System;

class GenericTest
{
  public static A Max<A>(A a, A b)
    where A : IComparable
  {
    return a.CompareTo(b) > 0 ? a : b;
  }
}

public class TestHoge
{
  public static void Main()
  {
    int n1 = GenericTest.Max<int>(5, 10);
    Console.Write(n1 + "\n");
    double n2 = GenericTest.Max(5.0, 10.0);
    Console.Write(n2 + "\n" );
    string n3 = GenericTest.Max("aaa", "bbb");
    Console.Write(n3 + "\n");
  }
}

