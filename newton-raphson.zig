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

fn fxa(comptime T: type, x: T) T {
    return 1 - 2 * x * @exp(-x / 2);
}

fn fx1a(comptime T: type, x: T) T {
    return (x - 2) * @exp(-x / 2);
}

fn fxb(comptime T: type, x: T) T {
    return 5 - std.math.pow(T, x, -1);
}

fn fx1b(comptime T: type, x: T) T {
    return std.math.pow(T, x, -2);
}

fn fxc(comptime T: type, x: T) T {
    return std.math.pow(T, x, 3) - 2 * x - 5;
}

fn fx1c(comptime T: type, x: T) T {
    return 3 * std.math.pow(T, x, 2) - 2;
}

fn fxd(comptime T: type, x: T) T {
    return @exp(x) - 2;
}

fn fx1d(comptime T: type, x: T) T {
    return @exp(x);
}

fn fxe(comptime T: type, x: T) T {
    return x - @exp(-x);
}

fn fx1e(comptime T: type, x: T) T {
    return 1 + @exp(-x);
}

fn fxf(comptime T: type, x: T) T {
    return std.math.pow(T, x, 6) - x - 1;
}

fn fx1f(comptime T: type, x: T) T {
    return 6 * std.math.pow(T, x, 5) - 1;
}

fn fxg(comptime T: type, x: T) T {
    return std.math.pow(T, x, 2) - @sin(x);
}

fn fx1g(comptime T: type, x: T) T {
    return 2 * x - @cos(x);
}

fn fxh(comptime T: type, x: T) T {
    return std.math.pow(T, x, 3) - 2;
}

fn fx1h(comptime T: type, x: T) T {
    return 3 * std.math.pow(T, x, 2);
}

fn fxi(comptime T: type, x: T) T {
    return x + @tan(x);
}

fn fx1i(comptime T: type, x: T) T {
    const cos_x = @cos(x);
    return 1 + (1.0 / (cos_x * cos_x));
}

fn fxj(comptime T: type, x: T) T {
    return 2.0 - (@log(x) / x);
}

fn fx1j(comptime T: type, x: T) T {
    return (@log(x) - 1.0) / (x * x);
}

pub fn main() !void {
    std.debug.print("NEWTON RAPHSON METHOD\n", .{});

    const xs: []const f32 = &.{ 1, 0, 0.25, 2, 1, 1, 1, 0.5, 1, 3, 0.3 };

    for (xs, 0..) |x, i| {
        const root = switch (i) {
            0 => newton_raphson(f32, fx, fx1, x, 1e-6),
            1 => newton_raphson(f32, fxa, fx1a, x, 1e-6),
            2 => newton_raphson(f32, fxb, fx1b, x, 1e-6),
            3 => newton_raphson(f32, fxc, fx1c, x, 1e-6),
            4 => newton_raphson(f32, fxd, fx1d, x, 1e-6),
            5 => newton_raphson(f32, fxe, fx1e, x, 1e-6),
            6 => newton_raphson(f32, fxf, fx1f, x, 1e-6),
            7 => newton_raphson(f32, fxg, fx1g, x, 1e-6),
            8 => newton_raphson(f32, fxh, fx1h, x, 1e-6),
            9 => newton_raphson(f32, fxi, fx1i, x, 1e-6),
            10 => newton_raphson(f32, fxj, fx1j, x, 1e-6),
            else => unreachable,
        };
        std.debug.print("Starting from x0 = {d}, the root is {d}\n", .{ x, root });
    }
}
