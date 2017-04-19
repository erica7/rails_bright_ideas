class IdeasController < ApplicationController

  def index
    @ideas = Idea.all.includes(:likes, :user)

    ##### This query orders the ideas by number of likes, but it uses `.joins` (an INNER JOIN) so it does not include ideas without any likes
    @ideas_ranked = Idea.joins(:likes).group("ideas.id").order("count(likes.id) desc")

    ##### I tried to use `.includes` (an OUTER JOIN) and order by number of likes, but didn't get a working solution
    # @ideas = Idea.includes(:likes, :users).order("count(likes.id) desc")
    # @ideas = Idea.includes(:likes, :user).order("count(likes) DESC")
    # @ideas = Idea.includes(:likes, :user).order("likes desc")
    # @ideas = Idea.includes(:likes, :user).group("ideas.id")
    # @ideas = Idea.includes(:likes, :user).group("ideas.id AS grouped_ideas")
    # @ideas = Idea.includes(:likes, :user).order('likes_count DESC')

    ##### I tried to get all ideas without any likes with the intention of appending them to the 'ranked' list, but didn't get a working solution
    # Idea.where("likes.size IS ?", 0)
    # Idea.includes(:likes).where( :likes => { :person_id => nil } )
    # Idea.where(likes.first: nil)
    # Idea.where("likes.first IS ?", nil)
    # Idea.includes(:likes, :users).where({ "likes.size" => 0 })
    # ideas = Idea.includes(:likes, :user).group("ideas.id").where("likes_count = '0'")
    # ideas = Idea.includes(:likes, :user).where("likes_count = '0'")
    # ideas = Idea.includes(:likes, :user).where(ideas.likes = nil)

    @current_user = current_user
  end

  def create
    idea = Idea.new(idea_params.merge(user: current_user))
    if not idea.save
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to '/ideas'
  end

  def show
    @idea = Idea.find(params[:id])
  end


  def destroy
    idea = Idea.find(params[:id])
    if not idea.destroy
      flash[:errors] = idea.errors.full_messages
    end
    redirect_to "/ideas"
  end

  private
    def idea_params
      params.require(:idea).permit(:content)
    end
end
