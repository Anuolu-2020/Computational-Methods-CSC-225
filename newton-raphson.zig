const std = @import("std");

fn newton_raphson(comptime T: type, f: fn (comptime T: type, T) T, f1: fn (comptime T: type, T) T, x: T, epsilon: f32) T {
    const derivative = f1(T, x);

    if (@abs(derivative) < 1e-10) {
        std.debug.print("Derivative is too close to zero at x = {d}\n", .{x});
        return x;
    }
    const xn = x - (f(T, x) / f1(T, x));

    if (@abs(xn - x) < epsilon) {
        return xn;
    }

    return newton_raphson(T, f, f1, xn, epsilon);
}

fn fx(comptime T: type, x: T) T {
    return x * x + x - 6;
}

fn fx1(comptime T: type, x: T) T {
    return 2 * x + 1;
}

pub fn main() !void {
    std.debug.print("NEWTON RAPHSON METHOD\n", .{});
    std.debug.print("SOLVING: x ^ 2 + x - 6\n", .{});

    const root = newton_raphson(f32, fx, fx1, 1, 1e-8);

    std.debug.print("The root is {d}\n", .{root});
}
