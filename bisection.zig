const std = @import("std");

fn bisection(comptime T: type, f: fn (comptime T: type, T) T, a: T, b: T, epsilon: f32) T {
    const fa = f(T, a);
    const fb = f(T, b);

    if (fa * fb > 0) {
        return -1;
    }

    const c = (a + b) / 2;

    const fc = f(T, c);

    if (@abs(fc) < epsilon or @abs(b - a) < epsilon) {
        return c;
    }

    if (fa * fc < 0) {
        return bisection(T, f, a, c, epsilon);
    } else {
        return bisection(T, f, c, b, epsilon);
    }
}

fn fx(comptime T: type, x: T) T {
    return 2 * (x * x) - 7 * x + 6;
}

pub fn main() !void {
    std.debug.print("BISECTION METHOD\n", .{});
    std.debug.print("SOLVING: 2x ^ 2 - 7x + 6\n", .{});
    const root = bisection(f32, fx, 1.6, 1, 1e-8);

    if (root == -1) {
        std.debug.print("No root found in the given interval\n", .{});
    } else {
        std.debug.print("The root is {d}\n", .{root});
    }
}
