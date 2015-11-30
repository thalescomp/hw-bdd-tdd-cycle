Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(:title => movie['title'], :rating => movie['rating'], :director => movie['director'], :release_date => movie['release_date'])
  end
end

Then /the director of "([^"]+)" should be "([^"]+)"/ do |title, director|
  movie = Movie.find_by :title => title
  page.current_path.should == movie_path(movie) # expect I am in the "movie/id" path
  movie.director.should == director # expect the Movie with that title has that director name
  page.body.should =~ /#{director}/ # expect the page of "movie/id" has the director name
end