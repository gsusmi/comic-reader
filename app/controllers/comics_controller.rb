class ComicsController < ApplicationController
  def index
    @feeds = feeds_for_user
  end

private
  def feeds_for_user
    # TODO
    Feed.all(order: 'name ASC')
  end
end
