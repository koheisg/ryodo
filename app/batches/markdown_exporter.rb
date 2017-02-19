class MarkdownExporter
  def self.run
    new.execute
  end

 def execute
   User.all.each do |user|
     user.articles.each do |article|
       FileUtils.mkdir_p "#{Rails.root}/tmp/user_#{user.id}/"
       f = File.open("#{Rails.root}/tmp/user_#{user.id}/#{article.title}.md", 'w')
       f.print front_matter(article.title)
       f.print article.content
       f.close
     end
   end
 end

 private

  def front_matter(title)
    <<"EOS"
---
layout: post
title: #{title}
---
EOS
  end
end
