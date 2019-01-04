def power_level(x, y, input)
  ((x + 10) * y + input) * (x + 10) / 100 % 10 - 5
end

def total(j, i, grid, d = 0, sign = 1)
  grid[i + d][j + d] - (
    (i > 0 ? grid[i - 1][j + d] : 0) +
    (j > 0 ? grid[i + d][j - 1] : 0) -
    (i > 0 && j > 0 ? grid[i - 1][j - 1] : 0)
  ) * sign
end

def max(input, size = 3)
  coords = (0...300).map { |y| (0...300).map { |x| [x + 1, y + 1] } }
  grid = coords.map { |row| row.map { |(x, y)| power_level(x, y, input) } }
  cumulative = Array.new(grid.length) { |i| [*grid[i]] }

  cumulative.each_with_index do |row, i|
    row.each_with_index do |_, j|
      cumulative[i][j] = total(j, i, cumulative, 0, -1)
    end
  end

  coords.flatten(1)
    .select { |(x, y)| x < 300 - size && y < 300 - size }
    .map { |(x, y)| [total(x - 1, y - 1, cumulative, size - 1), x, y] }
    .max_by(&:first)
end

def solve(input)
  (1..20).map { |size| [*max(input, size), size] }.max_by(&:first)[1..-1].join(',')
end

# p solve(18)
# p solve(42)
p solve(5719)
