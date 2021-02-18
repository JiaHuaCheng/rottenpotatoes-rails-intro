class Movie < ActiveRecord::Base
    #def self.all_ratings
    #    Movie.pluck(:rating).uniq   # search all ratings lable and handle duplication. 
    #end
    
    def self.all_ratings
		['G','PG','PG-13','R']
	end
	
	
end
