import std.stdio;
import std.range;

void main(string[] args) {
    foreach (argc, argv; args.enumerate)
        writefln("argv[%s] = <%s>", argc, argv);

}
