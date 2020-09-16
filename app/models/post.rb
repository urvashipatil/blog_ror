class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_rich_text :body

  default_scope {order(created_at: :desc)  }
  scope  :published,  -> {where(published: true)} 
  scope  :unpublished, -> {where.not(published: true)}

  # OR
  # scope :order_by_latest , -> {reorder(created_at: :desc)}

  # Getter
  def all_tags
    tags.map(&:name).join(", ")
    # tags.join(",")
  end

  # Setter
  def all_tags=(tag_names)
    if tag_names.blank?
      return
    end

    puts tag_names.split(",")
    
    self.tags = tag_names.split(",").map do |tag_name|
      unless tag_name.blank?
        puts tag_name.strip
        Tag.where(name: tag_name.strip).first_or_create!        
      end
    end

    # self.tag_ids = self.tags.map(&:id)

    p "***********************************self.tags self.tags self.tags"
    p self.tags
    
  end
end
