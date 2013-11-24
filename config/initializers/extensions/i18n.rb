module I18n
  def self.tmodel(model_class)
    model_class.model_name.human
  end
  
  def self.tattr(model_class, attrib_name)
    model_class.human_attribute_name(attrib_name)
  end

  def self.tbtn(key, params={})
    I18n.t("buttons.#{key}", params)
  end

  def self.tmsg(key, params={})
    I18n.t("messages.#{key}", params)
  end
  
  def self.terr(key, params={})
    I18n.t("errors.#{key}", params)
  end
end

