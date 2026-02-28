
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});



    const nanovg_module = b.addModule("nanovg", .{
        .target = target,
        .optimize = optimize,
    });

    nanovg_module.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &[_][]const u8{
            "nanovg.c",
        },
    });

    if (optimize == .Debug) { nanovg_module.addCMacro("DEBUG", ""); }
    else { nanovg_module.addCMacro("NDEBUG", ""); }
    nanovg_module.addIncludePath(b.path("src"));

    const lib_nanovg = b.addLibrary(.{
        .name = "nanovg",
        .root_module = nanovg_module,
        .linkage = .static,
    });

    b.installArtifact(lib_nanovg);
}

