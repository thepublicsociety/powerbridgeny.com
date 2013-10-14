module ApplicationHelper
  def title
    base_title = ""
    if @title.nil?
      base_title
    else 
      "#{@title} :: #{base_title}"
    end
  end
  def metatag
    base_desc = ""
    if @metatag.nil?
      base_desc
    else 
      "#{@metatag}"
    end
  end
  def bodyclass
    base_class = "page"
    if @bodyclass.nil?
      base_class
    else 
      "#{@bodyclass}"
    end
  end
  def smart_truncate(s, h, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '&hellip; <a href="'+h+'" class="more">read more &raquo;</a>' : '')
  end
  def word_truncate(s, opts = {})
    opts = {:words => 12}.merge(opts)
    if opts[:sentences]
      return s.split(/\.(\s|$)+/)[0, opts[:sentences]].map{|s| s.strip}.join('. ') + '.'
    end
    a = s.split(/\s/) # or /[ ]+/ to only split on spaces
    n = opts[:words]
    a[0...n].join(' ') + (a.size > n ? '&hellip;' : '')
  end
end
