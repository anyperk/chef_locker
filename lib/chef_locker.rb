require 'chef'

# @see #lock
class ChefLocker
  # @param output [#puts] IO-like object to output info to
  def initialize(output: $stdout)
    @output = output
    @runlock = Chef::RunLock.new(Chef::Config.lockfile)
  end

  # Locks Chef runs (prevents Chef clients from converging)
  #
  # @param message [#to_s] message to include in lock file
  def lock(message)
    message = message.to_s
    raise ArgumentError, "Message can't be blank" if message.strip.empty?

    @runlock.acquire
    begin
      @output.puts 'Lock acquired'
      @runlock.save_pid
      @runlock.runlock.write(' ' + message)
      @runlock.runlock.fsync

      # Now we block until interrupted (there might be a better way to do this)
      loop { $stdin.read }
    ensure
      @runlock.release
    end
  end
end
