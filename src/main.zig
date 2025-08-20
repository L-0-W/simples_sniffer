const std = @import("std");
const npcap = @cImport({
    @cDefine("WPCAP", "1");
    @cInclude("pcap.h");
    @cInclude("misc.h");
});


pub fn packet_handler(
    param: [*c]u8,
    header: [*c]const npcap.pcap_pkthdr,
    pkt_data: [*c]const u8,
) callconv(.C) void {
    _ = param;
    _ = pkt_data;

    const hdr = header.*;
    const sec = hdr.ts.tv_sec;
    const usec = hdr.ts.tv_usec;
    const caplen = hdr.caplen;
    const len = hdr.len;

    std.debug.print("Packet at {d}.{d} s: captured {} of {} bytes\n", .{ sec, usec, caplen, len });
}

pub fn main() !void {
    var alldevs: ?*npcap.pcap_if_t = null;
    var devs_element: ?npcap.pcap_if_t = null;
    var adhandle: ?*npcap.pcap_t = null;

    var i: i32 = 0;
    var errbuf: [256]u8 = undefined;

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    var buf: [10]u8 = undefined;

    if(npcap.LoadNpcapDlls() == 0){
        std.debug.print("Não pode iniciar loadNPcap", .{});
    }

    // Find all devices
    if (npcap.pcap_findalldevs(&alldevs, &errbuf) == -1) {
        const len = std.mem.indexOfScalar(u8, &errbuf, 0) orelse errbuf.len;
        const err_msg = errbuf[0..len];

        std.debug.print("Error finding devices: {s}", .{err_msg});
        return error.PcapError;
    }

    defer _ = npcap.pcap_freealldevs(alldevs);

    // Print device list
    var device = alldevs;
    while (device) |dev| {
        const name = std.mem.span(dev.name);
        const description = if (dev.description) |desc| std.mem.span(desc) else "No description";
        std.debug.print("Device: {s} - {s} - {d}\n", .{ name, description, i });
        device = dev.next;
        i+=1;
    }

    if( i==0 ){
        std.debug.print("Sem interface de rede", .{});
    }

    var opt: i64 = undefined;

    try stdout.print("Escolha uma rede: 0-{d}: ", .{i-1});
    if(try stdin.readUntilDelimiterOrEof(buf[0..], '\n')) |user_input| {
        const trimmed = std.mem.trim(u8, user_input, " \t\r\n");
        opt = std.fmt.parseInt(i64, trimmed, 10) catch |err| {std.debug.print("{}\n", .{err}); return;};
        std.debug.print("Escolhido: {!}\n", .{opt});
    } else {
        std.debug.print("{d}", .{@as(i64, 0)});
    }

    if (opt < 1 or opt > i){
        std.debug.print("Opção invalida: {d}\n", .{opt});
        std.debug.print("Disponiveis: 0-{d}", .{i-1});
        // LIBERAR ESPAÇO, VER SE PRECISA, PQ JA USO DEFER LA EM CIMA
    } else {
        std.debug.print("Existe\n", .{});
    }


    var j: i32 = 0;
    var device_ = alldevs;
    while(device_) |dev| {
        if (dev.next == null){
            break;
        }

        std.debug.print("opt: {d}  j: {d}\n", .{opt, j});
        if (opt == j) {
            devs_element = dev.*;
            break;
        }

        device_ = dev.next;
        j+=1;
    }


    adhandle = npcap.pcap_open(devs_element.?.name, 65536, npcap.PCAP_OPENFLAG_PROMISCUOUS, 1000, null, &errbuf);

    if(adhandle == null){
        std.debug.print("Não foi possivel abrir o dispositivo: {s}", .{devs_element.?.name});
    }

    defer npcap.pcap_close(adhandle);

    std.debug.print("Listeing on: {s}\n", .{devs_element.?.name});

    const result = npcap.pcap_loop(adhandle, 0, packet_handler, null);

    std.debug.print("Listeing on: {s}\n", .{devs_element.?.name});

    if (result == -1){
        const err = npcap.pcap_geterr(adhandle);
        std.debug.print("loop error: {s}\n", .{std.mem.span(err)});
    } else if (result == -2){
        std.debug.print("loop interrupt", .{});
    } else {
        std.debug.print("Captured {}", .{result});
    }
}
