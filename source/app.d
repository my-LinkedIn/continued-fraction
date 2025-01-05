import std.stdio;
import std.conv;
import std.algorithm;
import std.math;
import std.range;

string fmtContinued(bool exact, double firstNum, double[] sequence) {
    auto sequenceCycle = sequence.map!(n => n.to!string).cycle();
    auto sequenceLen = sequence.length;

    return "[ " ~ to!string(to!int(firstNum)) ~ "; " ~ (
        exact ? sequenceCycle.take(min(sequenceLen, 11)).join(", ") ~ (sequenceLen > 11 ? ", ..." : "")
              : (sequenceLen < 11 ? sequenceCycle.take(sequenceLen * 2).join(", ") ~ ", ..."
                                  : sequenceCycle.take(11).join(", "))
    ) ~ " ]";
}

string continued(double num) {
    double integerPart = floor(num);
    double firstInteger = integerPart;
    double fractionalPart = num % 1.0;
    double reciprocal = 1.0 / fractionalPart;
    double[] sequence;
    
    int len = 0;

    while (floor(fractionalPart * 10000.0) != 0.0) {
        integerPart = floor(reciprocal);
        fractionalPart = reciprocal % 1.0;
        reciprocal = 1.0 / fractionalPart;

        sequence ~= integerPart;
        len++;

        if (len % 11 == 0) {
            if (sequence[0 .. len / 11] == sequence[len / 11 .. len]) {
                writeln("repeating sequence found!");
                return fmtContinued(false, firstInteger, sequence[0 .. len / 11]);
            }
        }
    }
    
    return fmtContinued(true, firstInteger, sequence);
}

void main() {
    double exact = 415.0 / 93.0;
    writeln(continued(exact)); // [4; 2, 6, 7]

    double pattern = sqrt(19.0);
    writeln(continued(pattern)); // [4; 2, 1, 3, 1, 2, 8, 2, 1, 3, 1, 2, 8, ...]

    double pi = PI;
    writeln(continued(pi)); // [3; 7, 15, 1, 292, 1, 1, 1, 2, 1, 3, 1, ...]

    double e = E;
    writeln(continued(e)); // [2; 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ...]

    double phi = 1.618033988749894848204586834365638118;
    writeln(continued(phi)); // [1; 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...]

    double y = 0.57721566490153286060651209008240243104215933593992;
    writeln(continued(y)); // [0; 1, 1, 2, 1, 2, 1, 4, 3, 13, 5, 1, ...]

    double root2 = SQRT2;
    writeln(continued(root2));
}