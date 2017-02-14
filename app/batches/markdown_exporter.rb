class MarkdownExporter
  def self.run
    new.execute
  end

 def execute
  Article.all.each do |article|
    f = File.open("#{Rails.root}/tmp/#{article.title}.md", 'w')
    f.print article.content
    f.close
  end
 end
end
