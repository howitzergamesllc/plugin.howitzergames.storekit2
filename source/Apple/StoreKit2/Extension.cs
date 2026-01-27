using System;
using System.Runtime.InteropServices;
using CoreFoundation;
using Foundation;

namespace StoreKit2 {
    public partial class App {
        // Bind the numeric version
        [DllImport("__Internal")]
        internal static extern double StoreKit2VersionNumber();

        // Bind the string version
        [DllImport("__Internal")]
        internal static extern IntPtr StoreKit2VersionString();

        static string? versionString;

        public static string? VersionString {
            get {
                if (versionString == null) {
                    IntPtr strPtr = StoreKit2VersionString();
                    versionString = CFString.FromHandle(strPtr);
                }
                return versionString;
            }
        }

        public static double VersionNumber => StoreKit2VersionNumber();
    }
}
