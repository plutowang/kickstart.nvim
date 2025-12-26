const std = @import("std");
const print = std.debug.print;

fn runNeovimTest(allocator: std.mem.Allocator) !f64 {
    var child = std.process.Child.init(&[_][]const u8{ "nvim", "--headless", "+quit" }, allocator);
    child.stdout_behavior = .Ignore;
    child.stderr_behavior = .Ignore;

    const start_time = std.time.nanoTimestamp();

    try child.spawn();
    const term = try child.wait();

    const end_time = std.time.nanoTimestamp();

    switch (term) {
        .Exited => |code| {
            if (code != 0) return error.ProcessFailed;
        },
        else => return error.ProcessFailed,
    }

    const duration_ns = end_time - start_time;
    const duration_ms = @as(f64, @floatFromInt(duration_ns)) / 1_000_000.0;

    return duration_ms;
}

fn calculateStats(times: []const f64, count: usize, allocator: std.mem.Allocator) !void {
    if (count == 0) {
        print("❌ No successful runs recorded\n", .{});
        return;
    }

    const valid_times = times[0..count];

    // Calculate mean
    var sum: f64 = 0;
    var min_time: f64 = valid_times[0];
    var max_time: f64 = valid_times[0];

    for (valid_times) |time| {
        sum += time;
        if (time < min_time) min_time = time;
        if (time > max_time) max_time = time;
    }

    const mean = sum / @as(f64, @floatFromInt(count));

    // Calculate standard deviation
    var variance_sum: f64 = 0;
    for (valid_times) |time| {
        const diff = time - mean;
        variance_sum += diff * diff;
    }
    const variance = variance_sum / @as(f64, @floatFromInt(count));
    const std_dev = @sqrt(variance);

    // Calculate median
    const sorted = try allocator.dupe(f64, valid_times);
    defer allocator.free(sorted);
    std.mem.sort(f64, sorted, {}, comptime std.sort.asc(f64));

    const median = if (sorted.len % 2 == 0) blk: {
        const mid1 = sorted.len / 2 - 1;
        const mid2 = sorted.len / 2;
        break :blk (sorted[mid1] + sorted[mid2]) / 2.0;
    } else sorted[sorted.len / 2];

    // Print results
    print("\n==================================================\n", .{});
    print("NEOVIM STARTUP TIME ANALYSIS\n", .{});
    print("==================================================\n", .{});
    print("Successful runs: {d}/100\n", .{count});
    print("Average startup time: {d:.1} ms\n", .{mean});
    print("Median startup time: {d:.1} ms\n", .{median});
    print("Fastest startup: {d:.1} ms\n", .{min_time});
    print("Slowest startup: {d:.1} ms\n", .{max_time});
    print("Standard deviation: {d:.1} ms\n", .{std_dev});
    print("==================================================\n", .{});

    if (mean <= 25.0) {
        print("✅ EXCELLENT: {d:.1}ms meets 25ms target!\n", .{mean});
    } else if (mean <= 35.0) {
        print("✅ GOOD: {d:.1}ms is reasonably fast\n", .{mean});
    } else if (mean <= 50.0) {
        print("⚠️  FAIR: {d:.1}ms could be improved\n", .{mean});
    } else {
        print("❌ SLOW: {d:.1}ms needs optimization\n", .{mean});
    }
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const total_tests = 500;

    print("Testing Neovim startup time {d} times...\n", .{total_tests});
    print("This may take a few minutes...\n\n", .{});

    var times: [100]f64 = undefined;
    var count: usize = 0;

    var i: u32 = 1;
    while (i <= total_tests) : (i += 1) {
        if (i % 50 == 0) {
            print("Progress: {d}/{d} tests completed\n", .{ i, total_tests });
        }

        const startup_time = runNeovimTest(allocator) catch |err| switch (err) {
            error.ProcessFailed => {
                continue;
            },
            else => {
                print("Test {d} failed with error: {}\n", .{ i, err });
                continue;
            },
        };

        if (startup_time > 0 and count < times.len) {
            times[count] = startup_time;
            count += 1;
        }
    }

    try calculateStats(times[0..], count, allocator);
}
