const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    
    const optimize = b.standardOptimizeOption(.{});


    const lib_mod = b.createModule(.{

        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    // We will also create a module for our other entry point, 'main.zig'.
    const exe_mod = b.createModule(.{

        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    
    exe_mod.addIncludePath(.{ .cwd_relative = "C:/npcap-sdk-1.15/Include" });
    exe_mod.addLibraryPath(.{ .cwd_relative = "C:/npcap-sdk-1.15/Lib/x64"});
    exe_mod.addIncludePath(.{ .cwd_relative = "C:/npcap-sdk-1.15/Examples-remote/misc"});
    
    
    exe_mod.addImport("zigSniffer_lib", lib_mod);
    exe_mod.linkSystemLibrary("wpcap", .{});
    exe_mod.linkSystemLibrary("Packet", .{});
    exe_mod.linkSystemLibrary("ws2_32", .{});

    const lib = b.addLibrary(.{
        .linkage = .static,
        .name = "zigSniffer",
        .root_module = lib_mod,
    });


    b.installArtifact(lib);


    const exe = b.addExecutable(.{
        .name = "zigSniffer",
        .root_module = exe_mod,
    });


    b.installArtifact(exe);


    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());


    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);


    const lib_unit_tests = b.addTest(.{
        .root_module = lib_mod,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
}
