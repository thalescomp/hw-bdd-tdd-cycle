class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def find_similars_by_director
    if self.director && !self.director.empty?
      Movie.where(
        'director == :director and title != :title',
        :title => self.title,
        :director => self.director)
    else
      nil
    end
  end
end
