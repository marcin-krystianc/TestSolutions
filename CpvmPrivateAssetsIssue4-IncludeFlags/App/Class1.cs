using System;
using Newtonsoft.Json;

namespace App
{
    public class CLass1
    {
        void Method1()
        {
            var type = typeof(JsonConverter);
            if (type != null) throw new Exception();
        }
    }
}