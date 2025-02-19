const std = @import("std");

pub fn build(b: *std.Build) void {
    const test_step = b.step("test", "Test it");
    b.default_step = test_step;

    const optimize: std.builtin.OptimizeMode = .Debug;

    const exe = b.addExecutable(.{
        .name = "test",
        .root_source_file = .{ .path = "test.zig" },
        .optimize = optimize,
    });
    exe.addAnonymousModule("foo", .{
        .source_file = .{ .path = "foo.zig" },
    });

    const run = exe.run();

    test_step.dependOn(&run.step);
}
