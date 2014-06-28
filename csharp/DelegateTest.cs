using System;
using System.Threading;

// int型の引数一つをとって何も値を返さないdelegate型
/*
delegate void TestDelegateMethod(int a);

class DelegateTest
{
  static void Main()
  {
    TestDelegateMethod a = A;
    a(256);
  }
  static void A(int n)
  {
    Console.Write("A{0}がよばれました\n", n);
  }
}
*/

/*
// 引数を取らず、何も返さない
delegate void ShowMessage();

class Person
{
  string name;
  public Person(string name) { this.name = name; }
  public void ShowName() { Console.Write("名前 {0}\n", this.name); }
}

class TestDelegate
{
  static void Main()
  {
    Person p = new Person("テスト");
    ShowMessage show = p.ShowName;
    show();
  }
}
*/

/*
delegate void ShowMessage();

class DelegateTest
{
  static void Main()
  {
    ShowMessage a = A;
    a += B;
    a += C;
    a();
  }

  static void A() { Console.Write("Aだよ\n"); }
  static void B() { Console.Write("Bだよ\n"); }
  static void C() { Console.Write("Cだよ\n"); }
}
*/


namespace A
{
  public delegate void ShowMessage(int n);

  public class DelegateTest
  {
    static void Main()
    {
      const int N = 6;
      ShowMessage asyncCall = AsyncMethod;

      // asysCall を非同期を呼び出し
      // BeginInvokeで
      IAsyncResult ar = asyncCall.BeginInvoke(N, null, null);

      for (int i=0; i<N; ++i)
      {
        Thread.Sleep(600);
        Console.Write("Main {0}\n", i);
      }

      // asyncCall の処理が終わるの待つ
      asyncCall.EndInvoke(ar);
      Console.Write("処理完了");
    }

    static void AsyncMethod(int n)
    {
      for(int i=0; i<n; ++i)
      {
        Thread.Sleep(1000);
        Console.Write("AsyncMethod {0}\n", i);
      }
    }

  }
}





