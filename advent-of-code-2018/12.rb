require 'set'

INITIAL = '##.##..#.#....#.##...###.##.#.#..###.#....##.###.#..###...#.##.#...#.#####.###.##..#######.####..#'
ALIVE = File.foreach('12_input.txt').drop(2).map(&:split).group_by(&:last)['#'].map(&:first).to_set

def solve(gens)
  d = INITIAL.length * 10
  cushion = '.' * d
  initial = cushion + INITIAL + cushion

  gens.times.reduce({ state: initial, sums: [] }) { |acc, _|
    state = (2...initial.length - 2).reduce('..') { |s, i|
      s + (ALIVE.include?(acc[:state][i - 2..i + 2]) ? '#' : '.')
    } + '..'

    sum = state.chars.each_with_index.map { |c, i| c == '#' ? i - d : 0 }.sum

    { state: state, sums: [*acc[:sums], sum] }
  }
end

gens = 200
sums = solve(gens)[:sums]

p sums[19]

convergence = sums[1..-1].zip(sums).map { |x, y| x - y }.last

p sums[gens - 1] + convergence * (50_000_000_000 - gens)
