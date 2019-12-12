using System;
using System.IO;
using System.Linq;
using System.Text;

namespace SampleCli {
    class Program {
        static void Main(string[] args) {
            // Get (optional) data from an environment variable that can be passed in via Docker --env flags
            var data = Environment.GetEnvironmentVariable("MY_DATA") ?? "default data";

            // In our Dockerfile, we specify a VOLUME mount of C:\output, allowing us to write data that will persist
            // beyond the life of this ephemeral worker container.
            var filename = $"C:\\output\\{data}.txt";

            // Gen some sample data, and write it both to stdout as well as to a file in the mounted directory
            var sb = new StringBuilder();
            for (int i = 0; i <= 100; i++) {
                sb.Append($"{data} - iteration {i}{Environment.NewLine}");
            }
            var output = sb.ToString();

            Console.WriteLine(output);
            File.WriteAllText(filename, output);
        }
    }
}