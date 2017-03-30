module PageHelper
  def grid_classes(sidebar_menu, contact_detail, service, presented_client_story)
    if sidebar_menu.present? || presented_client_story.present? && (contact_detail.present? || (service.present? && service.facebook.present?))
      'medium-6 columns'
    elsif ((contact_detail.blank? || (service.present? && service.facebook.present?)) && sidebar_menu.present?) || (sidebar_menu.blank? && (contact_detail.present? || (service.present? && service.facebook.present?)))
      'medium-9 columns'
    else
      'small-12 columns'
    end
  end

  def sidebar_facebook_helper(url)
    content_for :head do
      raw '<script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v2.4";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, \'script\', \'facebook-jssdk\'));</script>'
    end

    raw "<div id='fb-root'></div>
    <div class='fb-page' data-href='#{url}' data-width='239' data-height='539'
    data-small-header='true' data-adapt-container-width='true'
    data-hide-cover='true' data-show-facepile='true' data-show-posts='true'>
    <div class='fb-xfbml-parse-ignore'><blockquote cite='#{url}'>
    <a href='#{url}'>Facebook</a></blockquote></div></div>
    "
  end
end
