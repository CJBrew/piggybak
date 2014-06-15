class AddDescriptionToLineItem < ActiveRecord::Migration
  def up
    add_column :line_items, :description, :string, :null => false, :default => ''

    Piggybak::LineItem.class_eval do
      self.table_name = 'line_items'
    end

    Piggybak::LineItem.all.each do |line_item|
      line_item.update_attribute(:description, line_item.variant.description)
    end
  end

  def down
    remove_column :line_items, :description
  end
end
