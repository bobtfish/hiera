class Hiera
  module Backend
    class Tcp_backend
      def initialize(cache=nil)

        Hiera.debug("Hiera TCP backend starting")
        require 'socket'
        @socket = TCPSocket.new 'localhost', 8141
      end

      def lookup(key, scope, order_override, resolution_type)
        Hiera.debug("Looking up #{key} in TCP backend")

        @socket.puts key
        answer = @socket.gets
        answer.chomp!

        Hiera.debug("Looking up #{key} in TCP backend got #{answer}")

        if answer == ""
          answer = nil
        end

        return answer
      end
    end
  end
end

