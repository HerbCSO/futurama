require 'delegate'

module Futurama
  class Future < Delegator
    def initialize(&block)
      @block = block
      @queue  = SizedQueue.new(1)
      @thread = Thread.new { run_future }
      @mutex  = Mutex.new 
    end

    def run_future
      @queue.push(value: @block.call)
    rescue Exception => ex
      @queue.push(exception: ex)
    end

    def __getobj__
      resolved_future_or_raise[:value]
    end
    alias_method :value, :__getobj__

    def resolved_future_or_raise
      @resolved_future || @mutex.synchronize do
        @resolved_future ||= @queue.pop
      end

      # Specifically using Kernel.raise here, because Thread.raise could change depending on the setting of #abort_on_exception
      #
      # From the Ruby Docs on Threads (https://ruby-doc.org/core-2.3.0/Thread.html):
      #
      # Any thread can raise an exception using the raise instance method, which operates similarly to Kernel#raise.
      #
      # However, it's important to note that an exception that occurs in any thread except the main thread depends on
      # abort_on_exception. This option is false by default, meaning that any unhandled exception will cause the thread to
      # terminate silently when waited on by either join or value. You can change this default by either abort_on_exception=
      # true or setting $DEBUG to true.
      Kernel.raise @resolved_future[:exception] if @resolved_future[:exception]
      @resolved_future
    end    
  end
end
