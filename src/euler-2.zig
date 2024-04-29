const std = @import("std");

pub fn main() !void {
    std.debug.print("Answer: {d}\n", .{sumFib(4e6)});
    // // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    // std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    // // stdout is for the actual output of your application, for example if you
    // // are implementing gzip, then only the compressed bytes should be sent to
    // // stdout, not any debugging messages.
    // const stdout_file = std.io.getStdOut().writer();
    // var bw = std.io.bufferedWriter(stdout_file);
    // const stdout = bw.writer();

    // try stdout.print("Run `zig build test` to run the tests.\n", .{});

    // try bw.flush(); // don't forget to flush!
}

fn sumFib(limit: u64) u64 {
    var sum: u32 = 0;
    var fib = FibSequence{};
    var tmp: u32 = 0;
    while (true) {
        tmp = fib.iter();
        if (tmp > limit) break;
        if (tmp % 2 == 0)
            sum += tmp;
    }
    return sum;
}

const FibSequence = struct {
    fib1: u32 = 0,
    fib2: u32 = 1,

    fn iter(self: *FibSequence) u32 {
        const tmp = self.fib2;
        self.fib2 = self.fib1 + self.fib2;
        self.fib1 = tmp;
        return self.fib2;
    }
};

test "fib struct" {
    var fib = FibSequence{};
    try std.testing.expect(1 == fib.iter());
    try std.testing.expect(2 == fib.iter());
}

test "test sum fib" {
    std.testing.log_level = .info;
    try std.testing.expectEqual(10, sumFib(20));
}
