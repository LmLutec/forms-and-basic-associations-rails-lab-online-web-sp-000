class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
  end

  def create
    
    @artist = Artist.find_or_create_by(name: song_params[:artist_name]) 
    @song = Song.new(song_params)
    @note = Note.find_or_create_by(content: song_params[:notes_contents])
    
    if @song.save
      redirect_to @song
    else
      redirect_to "/new"
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, notes_contents: [])
  end
end

##notes_contents= method will not work. Notes are being created correctly, just not persisting to the method in the model class