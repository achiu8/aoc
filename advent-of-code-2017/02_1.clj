(require '[clojure.string :as str])

(defn diff [xs]
  (- (apply max xs) (apply min xs)))

(defn parse-row [r]
  (map read-string (str/split r #"\t")))

(defn solve []
  (->> (slurp "02_input.tsv")
       (#(str/split % #"\n"))
       (map (comp diff parse-row))
       (reduce +)))

(println (solve))
