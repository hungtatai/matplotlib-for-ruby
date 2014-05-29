

require 'matplotlib/utils.rb'

silence_streams(STDERR) do
  require 'rubypython'

  RubyPython.start
  sys = RubyPython.import("sys")
  eval(`python -c "import sys; print sys.path"`).each do |p|
    sys.path.append(p)
  end

end

module Plot

  @@plt = RubyPython.import("matplotlib.pyplot")

  def self.plt
    @@plt
  end

  def self.subplots
    plt.subplots.to_a
  end

  def self.method_missing(method, *args, &block)
    begin
      @@plt.__send__(method.to_sym, *args, &block)
    rescue
      puts method
      super
    end
  end

end