class UpdateHonksAndBonksCounts < ActiveRecord::Migration[7.1]
  def up
    # Update honks_count for comments
    Comment.find_each do |comment|
      Comment.reset_counters(comment.id, :honks)
    end

    # Update bonks_count for comments
    Comment.find_each do |comment|
      Comment.reset_counters(comment.id, :bonks)
    end

    # Update honks_count for jests
    Jest.find_each do |jest|
      Jest.reset_counters(jest.id, :honks)
    end

    # Update bonks_count for jests
    Jest.find_each do |jest|
      Jest.reset_counters(jest.id, :bonks)
    end
  end

  def down
    # No need for down migration as this is just updating counts
  end
end
