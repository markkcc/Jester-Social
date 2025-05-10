class HallOfFameController < ApplicationController
  def index
    @top_honked_jests = Jest.where(audience: "circus")
                           .left_joins(:honks)
                           .group('jests.id')
                           .order('COUNT(honks.id) DESC')
                           .limit(5)

    @top_bonked_jests = Jest.where(audience: "circus")
                           .left_joins(:bonks)
                           .group('jests.id')
                           .order('COUNT(bonks.id) DESC')
                           .limit(5)

    @top_commented_jests = Jest.where(audience: "circus")
                              .left_joins(:comments)
                              .group('jests.id')
                              .order('COUNT(comments.id) DESC')
                              .limit(5)
  end
end 