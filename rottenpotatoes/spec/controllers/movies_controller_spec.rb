require 'spec_helper'
require 'rails_helper'

describe MoviesController do
    describe '.similars_by_director' do
        context 'with successful search' do
            before :each do
                @movie = FactoryGirl.create(:movie, title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: '1977-05-25')
                @fake_results = [double('similar_movie1'), double('similar_movie2')]
            end
            it 'should call the model method that performs movies search by director' do
                expect_any_instance_of(Movie).to receive(:find_similars_by_director).once.and_return(@fake_results)
                get :similars_by_director, {:id => @movie.id}
            end
            describe 'after search by director' do
                before :each do
                    allow_any_instance_of(Movie).to receive(:find_similars_by_director).and_return(@fake_results)
                    get :similars_by_director, {:id => @movie.id}    
                end
                it 'should select the Similars by Director template for rendering' do
                    expect(response).to render_template('similars_by_director')
                end 
                it 'should make similar movies available to that template' do
                    expect(assigns :similar_movies).to eq @fake_results
                end
                it 'should not redirect to movies path' do
                    expect(response).not_to redirect_to movies_path
                end 
                it 'should not make a flash message about movie with no director available to that template' do
                    expect(flash[:message]).not_to eq("'#{@movie.title}' has no director info")
                end                  
            end
        end
        
        context 'with movie without director' do
            before :each do
                @movie = FactoryGirl.create(:movie, title: 'Alien', rating: 'R', release_date: '1979-05-25')
                @fake_result = double('nil')
            end
            it 'should call the model method that performs movies search by director' do
                expect_any_instance_of(Movie).to receive(:find_similars_by_director).once.and_return(@fake_results)
                get :similars_by_director, {:id => @movie.id}
            end
            describe 'after search by director' do
                before :each do
                    allow_any_instance_of(Movie).to receive(:find_similars_by_director).and_return(@fake_results)
                    get :similars_by_director, {:id => @movie.id}    
                end
                it 'should redirect to movies path' do
                    expect(response).to redirect_to movies_path
                end 
                it 'should make a flash message about movie with no director available to that template' do
                    expect(flash[:message]).to eq("'#{@movie.title}' has no director info")
                end           
            end
        end
    end
end