N_PLAYERS = 465
LAST_MARBLE = 71940

class Node
  attr_accessor :val, :prv, :nxt

  def initialize(val, prv = self, nxt = self)
    @val = val
    @prv = prv
    @nxt = nxt
  end
end

def insert_after(node, i, val)
  curr = node
  i.times { curr = curr.nxt }
  insert = Node.new(val, curr, curr.nxt)
  curr.nxt.prv = insert
  curr.nxt = insert
  [insert.val, insert]
end

def delete(node, i)
  curr = node
  i.abs.times { curr = i.positive? ? curr.nxt : curr.prv }
  curr.prv.nxt = curr.nxt
  curr.nxt.prv = curr.prv
  [curr.val, curr.nxt]
end

def solve(n_players, last_marble)
  scores = Array.new(n_players) { 0 }
  curr = Node.new(0)

  (1..last_marble).each do |m|
    if m % 23 == 0
      val, curr = delete(curr, -7)
      scores[m % n_players - 1] += m + val
    else
      _, curr = insert_after(curr, 1, m)
    end
  end

  scores.max
end

def _solve(n_players, last_marble)
  scores = Array.new(n_players) { 0 }
  marbles = [0]
  i = 0

  (1..last_marble).each do |m|
    if m % 23 == 0
      i = (i - 7) % marbles.length
      scores[m % n_players - 1] += m + marbles.delete_at(i)
    else
      i = (i + 1) % marbles.length + 1
      marbles = [*marbles[0...i], m, *marbles[i..-1]]
    end
  end

  scores.max
end

p solve(10, 1618)
p solve(13, 7999)
p solve(17, 1104)
p solve(21, 6111)
p solve(30, 5807)
p solve(N_PLAYERS, LAST_MARBLE)
p solve(N_PLAYERS, LAST_MARBLE * 100)
