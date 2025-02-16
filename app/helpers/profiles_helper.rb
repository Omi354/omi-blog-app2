module ProfilesHelper
  def i18n_gender(user)
    I18n.t("enum.genders.#{user.display_gender}")
  end

  def map_genders_array
    Profile.genders.map { |k, v| [ I18n.t("enum.genders.#{k}"), k ] }
  end
end
