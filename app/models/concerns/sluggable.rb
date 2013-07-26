module Sluggable

  def to_param
    self.slug
  end

  def generate_slug(model, attribute)  #Post, self.title
    str = to_slug(attribute)
    count = 2
    obj = model.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = model.where(slug: str).first
      count += 1
    end
    self.slug = str.downcase
  end


  def to_slug(name)
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric with dash
     ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'

     #convert double dashes to single
     ret.gsub! /-+/,"-"

     #strip off leading/trailing dash
     ret.gsub! /\A[-\.]+|[-\.]+\z/,""

     ret
  end

end
