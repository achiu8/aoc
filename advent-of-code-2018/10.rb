def parse(xy)
  xy.split(', ').map(&:to_i)
end

points = File.foreach('10_input.txt').map do |line|
  Hash[[:p, :v].zip(line.match(/position=<(.*)> velocity=<(.*)>/)[1..2].map(&method(:parse)))]
end

SIZE = points.length - 125

def plot(points)
  grid = Array.new(SIZE) { Array.new(SIZE) { '.' } }

  points.each do |point|
    p = point[:p]
    grid[p[1]][p[0]] = '#'
  end

  grid.each do |line|
    puts line.join
  end

  puts
end

def focused(point)
  point[:p].all? { |p| p.abs <= SIZE && p.positive? }
end

def move(point)
  {
    p: [point[:p][0] + point[:v][0], point[:p][1] + point[:v][1]],
    v: point[:v]
  }
end

def solve(points)
  seconds = 0

  until points.all?(&method(:focused)) do
    points.map!(&method(:move))
    seconds += 1
  end

  while points.all?(&method(:focused)) do
    plot(points)
    points.map!(&method(:move))
    seconds += 1
  end

  seconds
end

p solve(points)
