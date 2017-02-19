class MarkdownExporter
  def self.run
    new.execute
  end

 def execute
   User.all.each do |user|
     user.articles.each do |article|
       FileUtils.mkdir_p "#{Rails.root}/tmp/user_#{user.id}/"
       f = File.open("#{Rails.root}/tmp/user_#{user.id}/#{article.title}.md", 'w')
       f.print article.content
       f.close
     end
   end
 end
end
