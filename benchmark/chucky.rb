require 'futurama'
require 'open-uri'
require 'json'
require 'benchmark'

class Chucky
  URL = 'http://api.icndb.com/jokes/random'
  Thread::abort_on_exception = true

  @@count = Hash.new { |h,k| h[k] = 0 }

  def sequential(prefix = 'sequential')
    open(URL) do |f|
      @@count[prefix] += 1
      res = []
      f.each_line { |line| res << "<#{prefix} #{@@count[prefix]}: [#{JSON.parse(line)['value']['joke']}] :end>\n" }
      res
    end
  end

  def concurrent
    future { sequential('concurrent') }
  end
end

chucky = Chucky.new

Benchmark.bmbm do |x|
  results = []
  x.report('concurrent') { 10.times { results << chucky.concurrent } }
  puts results
  results = []
  x.report('sequential') { 10.times { results << chucky.sequential } }
  puts results
end
