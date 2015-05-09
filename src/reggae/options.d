module reggae.options;
import std.file: thisExePath;


struct Options {
    string backend;
    string projectPath;
    string dflags;
    string reggaePath;
    string[string] userVars;
    string cCompiler;
    string cppCompiler;
    string dCompiler;
    bool help;
}


//getopt is @system
Options getOptions(string[] args) @trusted {
    import std.getopt;

    Options options;

    auto helpInfo = getopt(
        args,
        "backend|b", "Backend to use (ninja|make). Mandatory.", &options.backend,
        "dflags", "D compiler flags.", &options.dflags,
        "d", "User-defined variables (e.g. -d myvar=foo).", &options.userVars,
        "dc", "D compiler to use (default dmd).", &options.dCompiler,
        "cc", "C compiler to use (default gcc).", &options.cCompiler,
        "cxx", "C++ compiler to use (default g++).", &options.cppCompiler,
    );

    if(helpInfo.helpWanted) {
        defaultGetoptPrinter("Usage: reggae -b <ninja|make> </path/to/project>",
                             helpInfo.options);
        options.help = true;
    }

    options.reggaePath = thisExePath();
    if(args.length > 1) options.projectPath = args[1];

    if(!options.cCompiler)   options.cCompiler   = "gcc";
    if(!options.cppCompiler) options.cppCompiler = "g++";
    if(!options.dCompiler)   options.dCompiler   = "dmd";

    return options;
}
