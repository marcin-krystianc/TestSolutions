﻿
using Newtonsoft.Json.Bson.Converters;
namespace Lib2
{
    public class Lib
    {
        public void Method1()
        {
            var tmp1 = new BsonDataObjectIdConverter();
            var tmp2 = typeof(Newtonsoft.Json.JsonConverter<int>);
        }
    }
}