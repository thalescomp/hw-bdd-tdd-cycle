require 'spec_helper'
require 'rails_helper'

describe Movie do
    describe 'all_ratings' do     
        it 'should return ["G", "PG", "PG-13", "NC-17", "R"]' do
            expect(Movie.all_ratings).to eq ["G", "PG", "PG-13", "NC-17", "R"]
        end
    end    
    
    describe '[instance].find_similars_by_director' do
        before :each do
            @movie = FactoryGirl.create(:movie, :title => 'Milk', :rating => 'R', :director => 'Godofredo')
            @similar_movie1 = FactoryGirl.create(:movie, :title => 'Monkey', :rating => 'PG', :director => 'Godofredo')
            @similar_movie2 = FactoryGirl.create(:movie, :title => 'Money', :rating => 'PG-13', :director => 'Godofredo')
            @movie_with_no_director = FactoryGirl.create(:movie, :title => 'No Director', :rating => 'R', :director => nil)
        end        
        it 'should return "Monkey" and "Money" when searching for similars by director with "Milk"' do
            expect(@movie.find_similars_by_director).to be == [@similar_movie1, @similar_movie2]
        end
        it 'should return nil when searching for similars by director with "No Director"' do
            expect(@movie_with_no_director.find_similars_by_director).to eq(nil)
        end
    end
end