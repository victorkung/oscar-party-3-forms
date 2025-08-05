class MiscController < ApplicationController
  def homepage
    render({ :template => "misc_templates/home" })
  end

  def about
    render({ :template => "misc_templates/about" })
  end
end
