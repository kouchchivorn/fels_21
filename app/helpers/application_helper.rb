module ApplicationHelper
  def sidebar
    str = ''
    str += '<aside class="sidebar">'
    str += '<div id="logged_in">'
    if signed_in?
      str += "<p id=""user_info"">#{gravatar_for current_user} #{link_to(current_user.name, user_path(current_user))}<br>#{link_to('Logout', signout_path, :method => :delete)}</p>"
    else
      str += "<p id=""user_info"">#{link_to('Signin', signin_path)} | #{link_to('Signup', signup_path)}</p>"
    end
    str += '</div>'
    str += '</aside>'
    raw(str)
  end
end
