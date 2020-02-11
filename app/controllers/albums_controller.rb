class AlbumsController < ApplicationController
    def index
        @albums = Album.all
    end
    
    def show
        @album = Album.find(params[:id])
    end
    
    def new
        @album = Album.new
    end
    
    def edit
      @album = Album.find(params[:id])
    end
    
    def create
        @album = Album.new(album_params)
        
        @album.artwork = get_art(@album.album_title, @album.artist)
        if @album.save and @album.artwork != ""
            redirect_to @album
        else
            render 'new'
        end
    end
    
    def update
        @album = Album.find(params[:id])
        
        if @album.update(article_params)
            @album.artwork = get_art(@album.album_title, @album.artist)
            redirect_to @album
        else
            render 'edit'
        end
    end
    
    def destroy
    end
    
    private
      def album_params
        params.require(:album).permit(:album_title, :artist, :artwork)
      end
    
    private
      def get_art(title, artist)
          require 'json'
          require 'net/http'
          
          api = 'http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=b698bd0cd321931710479eb653eeca97&artist=%s&album=%s&format=json' % [artist, title]
          uri = URI(api)
          response = Net::HTTP.get(uri)
          begin
            return_str = JSON.parse(response)["album"]["image"][2]['#text']
          rescue NoMethodError
            return_str = ""
          end
          return return_str
      end
end
