class MoviesController < ApplicationController

  #def movie_params
  #  params.require(:movie).permit(:title, :rating, :description, :release_date)
  #end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    session.delete(:ratings_to_show) if params[:ratings].nil? and params[:commit] # params[:commit] is activated when we push buttom. Deselect all and push then clean. 
    session.delete(:sort_by) if params[:ratings].nil? and params[:commit]
    
    @sort_by = params[:sort_by] || session[:sort_by] 
    @all_ratings = Movie.all_ratings
    @ratings_to_show = params[:ratings] || session[:ratings_to_show]

    # use session to store previous result
    session[:ratings_to_show] = @ratings_to_show
    session[:sort_by] = @sort_by
    
    @ratings_to_show.nil? ? @movies = Movie.all : @movies = Movie.where(rating: @ratings_to_show.keys)

    @movies = @movies.order(@sort_by)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
