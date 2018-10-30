class StaticController < ApplicationController
  def team
  end

  def contact
  end

  def index
  end

  def index_post
  	puts params
  	@user = Gossip.new
  	@user.author = params["first_name"]
  	@user.save
  	redirect_to "/#{params["first_name"]}"
  end
  
  def user
  	@name = params[:id]
  end

  def user_post
    @gossip = Gossip.find_by(author: "#{params[:id]}")
    puts :id
    puts @gossip
    @gossip.content = params["content"]
    @gossip.save
  	redirect_to "/"
  end

  def gossip
  	@page = params[:id]
  end


end
