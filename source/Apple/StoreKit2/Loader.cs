using System;
namespace StoreKit2
{
	public class Loader
	{
		static Loader ()
		{
		}

		public static void ForceLoad () { }
	}
}

namespace ApiDefinition
{
	partial class Messaging
	{
		static Messaging ()
		{
			StoreKit2.Loader.ForceLoad ();
		}
	}
}
