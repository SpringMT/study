using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace console1
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			var test = RelayCommand.Execute("hogehoge");
			//test.Execute(HogeHoge);
			Console.Write("hogehoge");
		}
	}

	/*
	public interface ICommand<T>
	{
		void Execute(T parameter);
	}

	class Sample<T> : ICommand<T>
	{
		private readonly Action<T> execute;
		public Sample(Action<T> execute) : this(execute, null)
		{
		}

		public void Execute(T parameter)
		{
			this.execute(parameter);
		}
	}
	*/
	public interface ICommand<T>
	{
		event EventHandler CanExecuteChanged;

		bool CanExecute(T parameter);

		void Execute(T parameter);
	}

	public class RelayCommand<T> : ICommand<T>
	{
		private readonly Action<T> execute;
		private readonly Predicate<T> canExecute;

		public event EventHandler CanExecuteChanged;

		public RelayCommand(Action<T> execute)
			: this(execute, null)
		{
		}

		public RelayCommand(Action<T> execute, Predicate<T> canExecute)
		{
			if (execute == null)
				throw new ArgumentNullException("execute");

			this.execute = execute;
			this.canExecute = canExecute;
		}

		public bool CanExecute(T parameter)
		{
			return this.canExecute == null ? true : this.canExecute(parameter);
		}

		public void Execute(T parameter)
		{
			this.execute(parameter);
		}
	}

	class HogeHoge
	{
	
	}
}




