using System;

class Stack<T>
{
  static T[] buf = new T[10];
  static int top = 0;
  public static void Push(T val) {buf[top++] = val;}
  public static T Pop() { return buf[--top]; }
  public static int Size{ get{return top; } }
}

/*
class Hoge
{
  public static void Main()
  {
    for(int i=1; i<=10; ++i)
    {
      Stack<int>.Push(i);
      Stack<double>.Push(1.0/i);
      //sd.Push(1.0/i);
    }

    while(Stack<int>.Size != 0)
    {
      Console.Write("1/{0} = {1}\n", Stack<int>.Pop(), Stack<double>.Pop());
    }
  }
}
*/

/*
class ComplexGenerics
{
  static void Show<Type>(System.Collections.Generic.IList<Type> list)
  {
    foreach (Type x in list)
      Console.Write("{0}\n", x);
  }

  static void Main()
  {
    int[] a = new int[]{1,2,3,4};
    Show(a);
    double[] b = new double[]{1.0, 2.0 , 3.0};
    Show(b);
  }
}
*/

class DefaultGenerics
{
  static void FillWithDefault<T> (T[] array)
  {
    for(int i=0; i< array.Length; i++)
      array[i] = default(T);
  }

  static void Main()
  {
    int[] a = new int[5];
    string[] b = new string [5];
    FillWithDefault(a);
    FillWithDefault(b);
    foreach(int i in a)
      Console.Write(i);
    foreach(string n in b)
      Console.Write(n);
  }
}

