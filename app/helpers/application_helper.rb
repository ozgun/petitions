# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def html_title(title)
    content_for(:title) do
      "#{Sanitize.clean(title || '')} | "
    end
  end

  def title(pt=nil)
    pt || Sanitize.clean(current_page_title || '')
  end

  def title_with_category(category)
    if current_page_title and @category
      Sanitize.clean("#{current_page_title} &raquo; #{h(@category.name)}")
    else
      title 
    end
  end

  #def section_title(title)
  #  "<h2 id=\"section_title\">#{title}</h2>"
  #end

  # Hem sayfanın başlığı yazar hem de html'deki title tag'inin içini doldurur.
  def page_title(title)
    html_title(title)
    "<h2 id=\"page_title\">#{title}</h2>"
  end

  # Sayfa başlığını instance veya controller#action'lara göre belirle
  def current_page_title
    return @current_page_title if @current_page_title 
    title = ""
    if params[:controller] == "pages" and params[:action] == "show" and @page and @page.respond_to?(:title)
     title = @page.title
    elsif @product_page_title 
     title = @product_page_title
    elsif params[:controller] == "posts" and params[:action] == "show" and @post and @post.respond_to?(:title)
     title = @post.title
    elsif params[:controller] == "posts" and params[:action] == "index" 
      title = "AdTunnel Blog'u"
    elsif params[:controller] == "product_pages" and params[:action] == "show" and params[:page_type]
      case params[:page_type]
      when "google"
        title = t('page_title.product.google')
      when "facebook"
        title = t('page_title.product.facebook')
      when "mynet"
        title = t('page_title.product.mynet')
      when "seo"
        title = t('page_title.product.seo')
      end
    elsif request.request_uri =~ /\/satin-al/
      title = "Satın al" 
    elsif params[:controller] == "clients" and params[:action] == "index" 
      title = t('page_title.clients')
    elsif params[:controller] == "clients" and params[:action] == "show" and @client and @client.respond_to?(:name) 
      title = t('page_title.clients') + " - " + @client.name
    end 
    @current_page_title = title
  end

  def login_title(title)
    "<h2 class=\"login_title\">#{title}</h2>"
  end

  def image_sort_a_z
    image_tag("bullet_arrow_up.png", :title => "Ascending", :alt => "Ascending")
  end

  def image_sort_z_a
    image_tag("bullet_arrow_down.png", :title => "Descending", :alt => "Descending")
  end

  # Example: 
  # select_tag "category_id", options_for_select(..), {:selected => selected(:category_id)}
  def selected(select_element_id)
    params[select_element_id] ? params[select_element_id].to_i : nil
  end

  # This supports "strings"
  def selected2(select_element_id)
    params[select_element_id] ? params[select_element_id] : nil
  end

  # A quick fix for empty colums for blueprint css  
  def h_ext(txt)
    txt.blank? ? "&nbsp;" : h(txt)
  end

  def cycle_row
    cycle('odd', 'even')
  end

  def default_actions_opt
    {:show => true, :edit => true, :delete => true}
  end

  # obj => user
  # opts => {:show => true, :edit => true, :delete => true, :preview => true, :preview_link => "/contact?preview=1"}
  def actions_with_icons(obj, opts, prefix = "")
    return unless obj
    cls_name = obj.class.to_s.underscore
    unless prefix.empty?
      prefix = "#{prefix}_"
    end
    #admin_prefix = admin_pre ? "admin_" : ""
    r = [] 
    if opts[:preview] and opts[:preview_link]
      r << link_to(preview_icon, opts[:preview_link], :target => "_blank")
    end
    if opts[:new]
      r << link_to(add_icon, eval("new_#{prefix}#{cls_name}_path"))
    end
    if opts[:show]
      r << link_to(show_icon, eval("#{prefix}#{cls_name}_path(#{obj.id})"))
    end
    if opts[:edit]
      r << link_to(edit_icon, eval("edit_#{prefix}#{cls_name}_path(#{obj.id})"))
    end
    if opts[:delete]
      if opts[:delete_ajax]
        r << link_to_remote(delete_icon, :url => eval("#{prefix}#{cls_name}_path(#{obj.id})"), :method => :delete, :confirm => t('are_you_sure_delete'))
      else
        r << link_to(delete_icon, eval("#{prefix}#{cls_name}_path(#{obj.id})"), :method => :delete, :confirm => t('are_you_sure_delete'))
      end
    end
    r.join(' ')
  end

  def user_edit_icon(opts = nil)
    image_tag("user_edit.png", :alt => t('user.edit'), :title => t('user.edit'))
  end

  def edit_icon(opts = nil)
    image_tag("edit.png", :alt => t('edit'), :title => t('edit'))
  end

  def user_delete_icon(opts = nil)
    image_tag("user_delete.png", :alt => t('user.delete'), :title => t('user.delete'))
  end

  def delete_icon(opts = nil)
    image_tag("delete.png", :alt => t('delete'), :title => t('delete'))
  end

  def user_show_icon(opts = nil)
    image_tag("user_go.png", :alt => t('user.details'), :title => t('user.details'))
  end

  def show_icon(opts = nil)
    image_tag("go.png", :alt => t('details'), :title => t('details'))
  end

  def preview_icon(opts = nil)
    image_tag("go.png", :alt => t('preview'), :title => t('preview'))
  end

  def user_add_icon(opts = nil)
    image_tag("user_add.png", :alt => t('user.add'), :title => t('user.add'))
  end

  def add_icon(opts = nil)
    image_tag("add.png", :alt => t('add'), :title => t('add'))
  end

  def week_days
    ["Pazartesi", "Salı", "Çarşamba", "Perşembe", "Cuma", "Cumartesi", "Pazar"]
  end

  def yes_or_no(x)
    x ? "Evet" : "Hayır" 
  end

  def yes_or_no_icon(x)
    x ? image_tag("yes.png") :  image_tag("no.png")
  end
  
  def select_date_of_birth(frm)
    frm.date_select :date_of_birth, :order => [:month, :day, :year], :include_blank => true, :start_year => 1930, :end_year => (Date.today - 18.years).year
  end

  def initiate_tiny_mce
    content_for :head do
      javascript_include_tag('tiny_mce_jquery/tiny_mce') + javascript_include_tag('tiny_mce_init')
    end
  end

  # YÖnetim paneli
  def will_paginate_custom(collection)
    #will_paginate collection, :previous_label => "#{image_tag('previous.png')}#{t('pagination_pre')}", :next_label => "#{t('pagination_next')}#{image_tag('next.png')}"
    will_paginate collection, :previous_label => "«Önceki", :next_label => "Sonraki»"
  end

  # Kullanıcı ön yüzü
  def custom_pagination(collection)
    will_paginate(collection, :previous_label => "«Önceki", :next_label => "Sonraki»")
  end

  def asterisk
    '<span class="asterisk">*</span>'
  end

  def mandatory_field(str)
   (str + asterisk) unless str.blank?
  end

  # NOT: ref'in sonunda \r veya \r\n olabilir eğer 
  # textarea'dan veya dosyadan okunmuşsa!!
  def css_selected(ref)
    request.request_uri.include?(ref) ? "secili" : ""
  end

  # NOT: ref'in sonunda \r veya \r\n olabilir eğer 
  # textarea'dan veya dosyadan okunmuşsa!!
  def menu_css_selected(ref)
    request.request_uri.include?(ref.chomp) ? "selected" :  "not_selected"
  end
  
  def status_icon(x)
    x ? image_tag("yes.png") :  image_tag("no.png")
  end

  def status_desc(x)
    x ? t('active') : t('not_active')
  end

  def available_hours
    a = []
    8.upto(19) do |i|
      a << ["#{sprintf("%02d", i)}:00", i]
    end
    a
  end

  def select_countries(f, opts = {})
    default_opts = {:size => 5, :style => "width: 190px"}
    opts = default_opts.merge(opts)
    f.select :countries, 
      options_for_select(["Hepsi"] + 
                      Country.custom_sort.map {|c| [c.name_tr, c.name_tr]}, f.object.countries),
      {}, 
      {:multiple => true, :size => opts[:size], :style => opts[:style]}
  end

  def select_cities(f, opts = {})
    default_opts = {:size => 5, :style => "width: 190px"}
    opts = default_opts.merge(opts)
    f.select :cities, 
      options_for_select(["Hepsi"] + 
        City.custom_sort.map {|c| [c.name, c.name]}, f.object.cities), 
      {}, 
      {:multiple => true, :size => opts[:size], :style => opts[:style]}
  end

  def checked_or_not_icon(value, label)
    if value
      image_tag("checked.png") + label
    else
      image_tag("not_checked.png") + label
    end
  end

  def publish_status(value)
    if value
      image_tag("published.png", :title => t('published'), :alt => "published")
    else
      image_tag("not_published.png", :title => t('not_published'), :alt => "not_published")
    end
  end

  def document_path_by_section(document)
    opts = {:id => document.id, :permalink => document.permalink}
    case document.section_identifier
    when "dilekceler"
      petition_path(opts)
    when "sozlesmeler"
      agreement_path(opts)
    when "other_documents"
      other_document_path(opts)
    else
      "#"
    end
  end

  def print_categories(document)
    document.categories.map(&:name).join(', ') 
  end

end
