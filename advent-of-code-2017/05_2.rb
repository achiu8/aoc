Offsets = Struct.new(:current, :offsets) do
  def move
    jump = offsets[current]
    offsets[current] += jump >= 3 ? -1 : 1
    self.current += jump
    self.current >= offsets.length ? :done : self
  end
end

def solve(o)
  steps = 0
  while o != :done
    o = o.move
    steps += 1
  end
  steps
end

File.open('05_input.txt', 'r') do |f|
  offsets = f.each_line.map(&:to_i)
  p solve(Offsets.new(0, offsets))
end
