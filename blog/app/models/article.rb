class Article < ApplicationRecord
    include AASM 

    
    #Al crear el modelo, asocia directamente la tabla como Articles (el modelo en plural)
    belongs_to        :user
    has_many          :comments, dependent: :delete_all
    has_many          :has_categories, dependent: :delete_all
    has_many          :categories, through: :has_categories, dependent: :delete_all

    #Sin el dependent: :delete_all no se pueden borrar, ya que da error de FK

    validates         :title, presence:true, uniqueness: true
    validates         :body, presence:true, length: {minimum: 20}
    before_create     :set_visits_count
    after_create      :save_categories

    has_attached_file :cover, styles: {medium: "1280x720", thumb: "800x500"}
    validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

    scope :publicados, ->{where(state: "published")}

    scope :ultimos, ->{order("created_at DESC")}

    #def self.publicados
    #    Article.where(state:"published")
    #end

    #custom setter
    def categories=(value)
        @categories = value
    end

    def update_visits_count
        self.update(visits_count: self.visits_count + 1)
    end

    aasm column: "state" do
        state :in_draft, initial: true
        state :published

        event :publish do
            transitions from: :in_draft, to: :published
        end

        event :unpublish do
            transitions from: :published, to: :in_draft
        end
    end

    

    private
    
    #def send_mail
    #    ArticleMailer.new_article(self).deliver_later
    #end

    def save_categories
        @categories.each do |category_id|
            HasCategory.create(category_id: category_id, article_id: self.id)
        end
    end

    def set_visits_count
        self.visits_count ||= 0
    end
end
