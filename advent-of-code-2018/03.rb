require 'set'

def parse(s, sep)
  s.split(sep).map(&:to_i)
end

def area(claim)
  (claim[:x]...claim[:x] + claim[:w]).flat_map do |x|
    (claim[:y]...claim[:y] + claim[:h]).map do |y|
      "#{x}-#{y}"
    end
  end
end

def claims
  File.foreach('03_input.txt').map do |line|
    matches = line.match(/#(\d+) @ (\d+,\d+): (\d+x\d+)/)
    id = matches[1].to_i
    x, y = parse(matches[2], ',')
    w, h = parse(matches[3], 'x')

    { id: id, x: x, y: y, w: w, h: h }
  end
end

def solve
  claim_areas = claims.map { |claim| { id: claim[:id], area: Set.new(area(claim)) } }

  total = claim_areas.reduce({ total: Set.new, overlap: Set.new }) do |acc, claim|
    {
      total: acc[:total] + claim[:area],
      overlap: acc[:overlap] + (acc[:total] & claim[:area])
    }
  end

  intact = claim_areas.find { |claim| (claim[:area] & total[:overlap]).empty? }

  [total[:overlap].size, intact[:id]]
end

p solve
