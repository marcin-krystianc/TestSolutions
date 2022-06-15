namespace CSharpProject;

public static class Say
{
#if FOO
    public static void Hello(string name) => Console.WriteLine($"Foo {name}");
#else
    public static void Hello(string name) => Console.WriteLine($"Hello {name}");
#endif
}