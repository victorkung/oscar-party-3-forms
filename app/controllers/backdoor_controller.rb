class BackdoorController < ApplicationController

  def backdoor_index
    render({ :template => "backdoor_templates/backdoor_index" })
  end

end
