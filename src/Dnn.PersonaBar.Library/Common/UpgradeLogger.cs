using System;
using System.IO;

namespace Dnn.PersonaBar.Library.Common
{
    public static class UpgradeLogger
    {
        public static void Log(string data)
        {
            var fileNae = Path.Combine(DotNetNuke.Common.Globals.ApplicationMapPath, "App_Data/PB_UpgradeLog.txt");
            File.AppendAllText(fileNae, DateTime.Now + " " + data + Environment.NewLine);
        }
    }
}
