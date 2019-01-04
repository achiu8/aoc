(require '[clojure.string :as str])

(defn result [xs]
  (let [[x y] (reduce (fn [acc x]
                        (reduce (fn [yacc y]
                                  (cond (not (empty? yacc)) yacc
                                        (and (not (= x y)) (= 0 (mod x y))) [x y]
                                        :else []))
                                acc
                                xs))
                      []
                      xs)]
    (/ x y)))

(defn parse-row [r]
  (map read-string (str/split r #"\t")))

(defn solve []
  (->> (slurp "02_input.tsv")
       (#(str/split % #"\n"))
       (map (comp result parse-row))
       (reduce +)))

(println (solve))
