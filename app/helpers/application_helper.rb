module ApplicationHelper

  def fix_url(url)
    if (url[0..3] == "http")
      url
    else
     "http://#{url}"
    end
  end

  def display_time(time)
    time_ago_in_words(time, include_seconds: true)
  end

end
