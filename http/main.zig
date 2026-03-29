const std = @import("std");

pub fn main() !void {
    const address = try std.net.Address.parseIp4("127.0.0.1", 8080);
    var server = try address.listen(.{});
    defer server.deinit();
    std.debug.print("http://localhost:{d}\n", .{address.getPort()});
    while (true) {
        const conn = try server.accept();
        try handleConnection(conn);
    }
}

fn handleConnection(conn: std.net.Server.Connection) !void {
    defer conn.stream.close();
    var reader_buf: [1024]u8 = undefined;
    var writer_buf: [1024]u8 = undefined;
    var reader = conn.stream.reader(&reader_buf).file_reader;
    var writer = conn.stream.writer(&writer_buf).file_writer;
    var server = std.http.Server.init(&reader.interface, &writer.interface);
    var req = try server.receiveHead();
    try req.respond("Hello world!", .{});
}
