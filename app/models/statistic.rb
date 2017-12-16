class Statistic < ApplicationRecord
  def calculate_ranking(people, rating)
    average_all_votes = all_reviews / all_products
    average_all_rating = all_rating / all_products
    cal = ((average_all_votes * average_all_rating) + (people * rating)) / (average_all_votes + people)
    return cal
  end
end
