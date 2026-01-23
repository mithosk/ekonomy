module UserHelper
  def checkbox_state(checkbox_name:, db_flag:)
    state = ""

    if request.post?
      state = "checked" if params[checkbox_name] == "on"
    else
      state = "checked" if db_flag == true
    end

    state
  end
end
