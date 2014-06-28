using System;

namespace conosle1
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			//Console.Write("What your name ?");
			//var name = Console.ReadLine();
			var sample = new Sample();
			sample.Set(45, 2);
			Console.Write(sample.GetX());
		}
	}

	class Sample
	{
		// メンバー変数の定義 ここから↓
		private int x;
		private int y;
		// メンバー変数の定義 ここまで↑

		// メソッドの定義 ここから↓
		public int GetX()
		{
			return x;
		}

		public int GetY()
		{
			return y;
		}

		public void Set(int a, int b)
		{
			x = a;
			y = b;
		}
		// メソッドの定義 ここまで↑
	}
}
