require 'hiera'

defaultval = ""

scope = {
  'hostname' => 'foo',
  'domain'   => 'bar',
  'fqdn'     => 'foo.bar'
}

hiera = Hiera.new(:config => "/etc/hiera-server.yaml")

require 'socket'

server = TCPServer.new 8141
loop do
  Thread.start(server.accept) do |client|
    key = client.gets
    key.chomp!

    client.puts "#{hiera.lookup(key, nil, scope)}\n"
  end
end

