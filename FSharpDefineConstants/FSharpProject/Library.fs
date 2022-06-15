namespace FSharpProject

module Say =
#if FOO
    let hello name = printfn "Foo %s" name
#else
    let hello name = printfn "Hello %s" name
#endif